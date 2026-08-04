<?php
/*
 * @copyright   QiaoQiaoShiDai Internet Technology(Shanghai)Co.,Ltd
 * @license     https://www.oaooa.com/licenses/
 *
 * @link        https://www.oaooa.com
 * @author      zyx(zyx@oaooa.com)
 */
if (!defined('IN_OAOOA')) {
    exit('Access Denied');
}
global $_G;
$path = isset($_GET['path']) ? trim($_GET['path']):'';
if(!$path = Decode($path,'read')){
    @header( 'HTTP/1.1 403 Not Found' );
    @header( 'Status: 403 Not Found' );
    exit('File not found');
}
//兼容老版本
$path=str_replace('_3','',$path);

$rid = $path;

//是否忽略密级权限
$ulevel = intval(getglobal('pichomelevel') );
//是否获取真实文件地址

if(strpos($path, 'attach::') === 0){
    $thumbpath = $path;
    $resourcesdata = IO::getMeta($path);
}else {
    $resourcesdata = C::t('pichome_resources')->fetch($rid);
}
if(!$resourcesdata){
    exit('file is not exists');
}

$resourcesdata['name'] = preg_replace('/\.'.$resourcesdata['ext'] . '/', '', $resourcesdata['name']);
$resourcesdata['name'] .='.'. $resourcesdata['ext'];

if($resourcesdata['level']  &&  $ulevel < $resourcesdata['level']){
    @header('HTTP/1.1 403 No Perm');
    @header('Status: 404 No Perm');
    exit('No Level Permission');
}

$url = IO::getStream($path);

$filename = $_GET['filename'] ? getstr($_GET['filename']) : $resourcesdata['name'];

// 定义要移除的后缀
$suffix = '\.dzz$';

// 使用正则表达式替换后缀
$filename = preg_replace('/' . $suffix . '/', '', $filename);

$ext = strtolower(substr(strrchr($filename, '.'), 1, 10));
if (!$ext) $ext = strtolower(substr(strrchr(preg_replace("/\.dzz$/i", '', preg_replace("/\?.*/i", '', $url)), '.'), 1, 10));

$mime = dzz_mime::get_type($ext);

if (is_file($url)) {
    $name = $filename;
    $total = filesize($url);

    header("Cache-Control: private, max-age=2592000, pre-check=2592000");
    header("Pragma: private");
    header("Expires: " . date(DATE_RFC822, strtotime(" 30 day")));
    $lastModified = @filemtime($url);
    if ($lastModified) {
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s', $lastModified) . ' GMT');
    }

    if (isset($_SERVER['HTTP_RANGE'])) {
        $rangeHeader = trim($_SERVER['HTTP_RANGE']);
        if (preg_match('/bytes=(\d*)-(\d*)/i', $rangeHeader, $matches)) {
            $reqStart = ($matches[1] === '') ? null : intval($matches[1]);
            $reqEnd   = ($matches[2] === '') ? null : intval($matches[2]);

            $start = ($reqStart === null) ? 0 : $reqStart;
            $end   = ($reqEnd === null) ? ($total - 1) : $reqEnd;

            if ($start >= $total) {
                header('HTTP/1.1 416 Requested Range Not Satisfiable');
                header('Content-Range: bytes */' . $total);
                exit();
            }
            if ($end >= $total) $end = $total - 1;
            if ($end < $start) $end = $start;

            $size = $end - $start + 1;
            header('HTTP/1.1 206 Partial Content');
            header('Accept-Ranges: bytes');
            header('Content-Length:' . $size);
            header('Content-Range: bytes ' . $start . '-' . $end . '/' . $total);
            header('Content-Type:' . $mime);

            $fp = fopen($url, 'rb');
            if ($fp === false) {
                exit('Cannot open file');
            }
            fseek($fp, $start, 0);
            $cur = $start;
            @ob_end_clean();
            if (getglobal('gzipcompress')) @ob_start('ob_gzhandler');
            while (!feof($fp) && $cur <= $end && (connection_status() == 0)) {
                print fread($fp, min(1024 * 16, ($end - $cur) + 1));
                $cur += 1024 * 16;
                @ob_flush();
                @flush();
            }
            fclose($fp);
            exit();
        }
    }

    // ============ 非 Range 请求(完整下载) ============
    header('HTTP/1.1 200 OK');
    header('Accept-Ranges: bytes');
    header('Content-Length:' . $total);
    header('Content-Type:' . $mime);

    $fp = fopen($url, 'rb');
    if ($fp !== false) {
        $cur = 0;
        @ob_end_clean();
        if (getglobal('gzipcompress')) @ob_start('ob_gzhandler');
        while (!feof($fp) && $cur < $total && (connection_status() == 0)) {
            print fread($fp, min(1024 * 16, $total - $cur));
            $cur += 1024 * 16;
            @ob_flush();
            @flush();
        }
        fclose($fp);
    }
    exit();
} else {
    header('HTTP/1.1 302 Found');
    header('Accept-Ranges: bytes');
    header('Content-Type: ' . $mime);
    header('Location: ' . $url);
    exit();
}