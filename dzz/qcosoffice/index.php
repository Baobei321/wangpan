<?php
/*
 * @copyright   QiaoQiaoShiDai Internet Technology(Shanghai)Co.,Ltd
 * @license     https://www.oaooa.com/licenses/
 *
 * @link        https://www.oaooa.com
 */
if(!defined('IN_OAOOA') ) {
    exit('Access Denied');
}
if(!$rid = dzzdecode($_GET['path'],'',0)){
    exit('Access Denied');
}
$data = C::t('pichome_resources')->fetch_data_by_rid($rid);
$did = $data['remoteid'];
$connectdata =  C::t('connect_storage')->fetch($did);
if(!$connectdata['docstatus']){
    showmessage('该文件预览需文档处理支持，当前存储位置未开启文档处理，如需预览请联系管理员开启文档处理');
    exit();
}else{
    $url = IO::getFileUri($data['path']);
    $signedUrl = explode('?',$url);
    $url = $signedUrl[0].'?ci-process=doc-preview&dstType=html&'.$signedUrl[1];
    $filename = rtrim($_GET['n'], '.dzz');
    $ext = strtolower(substr(strrchr($filename, '.'), 1, 10));
    if (!$ext) $ext = strtolower(substr(strrchr(preg_replace("/\.dzz$/i", '', preg_replace("/\?.*/i", '', $url)), '.'), 1, 10));
    $mime = 'html';
    if (is_file($url)) {
        $filename = $url;
        $start = 0;
        $total = filesize($filename);
        header("Cache-Control: private, max-age=2592000, pre-check=2592000");
        header("Pragma: private");
        header("Expires: " . date(DATE_RFC822, strtotime(" 30 day")));
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s', filemtime($filename)) . ' GMT');
        if (isset($_SERVER['HTTP_RANGE'])) {
            $range = str_replace('=', '-', $_SERVER['HTTP_RANGE']);
            $range = explode('-', $range);
            if (isset($range[2]) && intval($range[2]) > 0) {
                $end = trim($range[2]);
            } else {
                $end = $total - 1;
            }
            $start = trim($range[1]);
            $size = $end - $start + 1;

            header('HTTP/1.1 206 Partial Content');
            header('Content-Length:' . $size);
            header('Content-Range: bytes ' . $start . '-' . $end . '/' . $total);

        } else {
            $size = $end = $total;

            header('HTTP/1.1 200 OK');
            header('Content-Length:' . $size);
            header('Content-Range: bytes 0-' . ($total - 1) . '/' . $total);
        }
        header('Accenpt-Ranges: bytes');
        header('Content-Type:' . $mime);
        $fp = fopen($filename, 'rb');
        fseek($fp, $start, 0);

        $cur = $start;
        @ob_end_clean();
        if (getglobal('gzipcompress')) @ob_start('ob_gzhandler');
        while (!feof($fp) && $cur <= $end && (connection_status() == 0)) {
            print fread($fp, min(1024 * 16, ($end - $cur) + 1));
            $cur += 1024 * 16;
        }

        fclose($fp);
        exit();
    } else {
        //$cachefile=$_G['siteurl']['attachdir'].'cache/'.play_cache_md5(file).'.'.$ext;
        //$meta=IO::getMeta($path);
        //$size=$meta['size'];

        header("Cache-Control: private, max-age=2592000, pre-check=2592000");
        header("Pragma: private");
        header("Expires: " . date(DATE_RFC822, strtotime(" 30 day")));
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s', filemtime($url)) . ' GMT');
        header('Content-Type: ' . $mime);
        //header('Content-Length:'.$size);
        //header('Content-Range: bytes 0-'.($size-1).'/'.$size);
        @ob_end_clean();
        if (getglobal('gzipcompress')) @ob_start('ob_gzhandler');
        @readfile($url);
        @flush();
        @ob_flush();
        exit();
    }
}
