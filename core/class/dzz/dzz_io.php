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
    
    
    class dzz_io
    {
        protected function initIO($path)
        {
            $path = self::clean($path);
            $bzarr = explode(':', $path);
            $allowbz = C::t('connect')->fetch_all_bz();//array('baiduPCS','ALIOSS','dzz','JSS','disk');
            if (in_array($bzarr[0], $allowbz)) {
                $classname = 'io_' . $bzarr[0];
            } else{
                $classname = 'io_dzz';
            }
            
            return new $classname($path);
        }
        
        function MoveToSpace($path, $attach, $ondup = 'overwrite')
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                return $io->MoveToSpace($path, $attach, $ondup);
            } else {
                return false;
            }
        }
        
        function authorize($bz, $refer = '')
        {
            if ($io = self::initIO($bz)) {
                $io->authorize($refer);
            }
        }
        
        function getQuota($bz)
        {
            if ($io = self::initIO($bz)) {
                return $io->getQuota($bz);
            } else {
                return false;
            }
        }
        
        function chmod($path, $chmod, $son = 0)
        {
            if ($io = self::initIO($path)) {
                return $io->chmod($path, $chmod, $son);
            } else {
                return false;
            }
        }
        
        function parsePath($path)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                return $io->parsePath($path);
            } else {
                return false;
            }
        }
        
        function output_thumb($file, $mine = 'image/JPEG')
        {//根据文件地址，输出图像流
            global $_G;
            $last_modified_time = filemtime($file);
            if ($last_modified_time) {
                $etag = md5_file($file);
                header("Last-Modified: " . gmdate("D, d M Y H:i:s", $last_modified_time) . " GMT");
                header("Etag: $etag");
                if (@strtotime($_SERVER['HTTP_IF_MODIFIED_SINCE']) == $last_modified_time ||
                    trim($_SERVER['HTTP_IF_NONE_MATCH']) == $etag
                ) {
                    header("HTTP/1.1 304 Not Modified");
                    exit;
                }
            }
            /*if(!$last_modified_time) $last_modified_time = TIMESTAMP;*/
            @header('cache-control:public');
            header('Content-Type: ' . $mine);
            @ob_end_clean();
            if (getglobal('gzipcompress')) @ob_start('ob_gzhandler');
            @readfile($file);
            @flush();
            @ob_flush();
            exit();
        }
        
        //获取缩略图
        function getThumb($path, $thumbsign, $original, $returnurl = false, $create = 0, $thumbtype = 1, $extpramas = array())
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->getThumb($path, $thumbsign, $original, $returnurl, $create, $thumbtype, $extpramas);
        }

        function getPreviewThumb($path, $thumbsign, $original, $returnurl = false, $create = 0, $thumbtype = 1, $extpramas = array()){
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->getPreviewThumb($path, $thumbsign, $original, $returnurl, $create, $thumbtype, $extpramas);
        }

        //获取文件信息
        function getfilesinfo($path){
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->getfilesinfo($path);
        }
        
        function createThumbByOriginal($path,$data, $width, $height, $thumbtype = 1, $original = 0, $extraparams = array(),$filesize=0)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->createThumbByOriginal($path,$data,$width, $height, $thumbtype, $original, $extraparams,$filesize);
        }
        function gettmpThumb($path, $width = 0, $height = 0, $returnurl = false, $thumbtype = 1, $extraparams = array()){
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->gettmpThumb($path,$width, $height,$returnurl, $thumbtype, $extraparams);
        }
        /*
         *通过icosdata获取folderdata数据
        */
        function getFolderByIcosdata($icosdata)
        {
            if ($io = self::initIO($icosdata['path'])) return $io->getFolderByIcosdata($icosdata);
            else return false;
        }
        //获取icosdata数组；
        //$path: 路径
        //$getimagedata 是否获取图片宽高等数据
        //$bz==''是表示获取的是本地；此时path为icoid；
        function getMeta($path, $getimagedata = 0)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->getMeta($path, $getimagedata);
            else return false;  
        }
        
        //重命名文件
        function rename($path, $newname)
        {
            $path = self::clean($path);
            $newname = self::name_filter($newname);
            if ($io = self::initIO($path)) {
                $return = $io->rename($path, $newname);
                //Hook::listen('renameafter_updateindex',$return);
                return $return;
            } else return false;
        }
        
        
        //根据路径获取目录树的数据；
        function getFolderDatasByPath($path)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->getFolderDatasByPath($path);
            else return false;
        }
        //判断文件或目录是否存在
        public function checkfileexists($path,$isdir = false){
            $io = self::initIO($path);
            if ($io){
                $path = self::clean($path);
                return $io->checkfileexists($path,$isdir);
            }
            else return false;
        }

        //获取文件时间
        public function getFimemtime($path){
            $io = self::initIO($path);
            if ($io){
                $path = self::clean($path);
                return $io->getFimemtime($path);
            }
            else return false;
        }
        //获取文件流；
        //$path: 路径
        public function getStream($path, $fop = 0)
        {
            $io = self::initIO($path);
            if ($io){
				$path = self::clean($path);
				return $io->getStream($path, $fop);
			} 
            else return $path;
        }
        //获取文件地址；
        //$path: 路径
        function getFileUri($path, $fop = 0)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->getFileUri($path, $fop);
            else return $path;
        }
        function getFolderlist($path,  $nextmarker = '',$by = 'time',$order = 'DESC', $limit = 1000, $force = 0)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->getFolderlist($path, $nextmarker,$by, $order, $limit, $force);
            else return false;
        }
        /**
         * 获取指定文件夹下的文件列表
         * @param string $path 文件路径
         * @param string $by 排序字段，缺省根据文件类型排序，time（修改时间），name（文件名），size（大小，注意目录无大小）
         * @param string $order asc或desc，缺省采用降序排序
         * @param string $limit 返回条目控制，参数格式为：n1-n2。返回结果集的[n1, n2)之间的条目，缺省返回所有条目。n1从0开始。
         * @param string $force 读取缓存，大于0：忽略缓存，直接调用api数据，常用于强制刷新时。
         * @return icosdatas
         */
        function listFiles($path,  $nextmarker = '',$by = 'time',$order = 'DESC', $limit = 1000, $force = 0)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->listFiles($path,  $nextmarker,$by,$order, $limit, $force);
            else return false;
        }
        
        //目标位置新建内容
        //$path:原路径
        //$container:目标位置；
        //$tbz:目标api；
        //返回：
        //$icosdata数组；
        function CopyTo($opath, $path, $iscopy = 0, $force = 0)
        {
            $path = self::clean($path);
            $opath = self::clean($opath);
            if ($io = self::initIO($opath)) return $io->CopyTo($opath, $path, $iscopy, $force);
            else return false;
        }
        
        /**
         * 删除指定的元素
         * @param string $opath 被移动的文件路径
         * @param string $path 目标位置（可能是同一api内或跨api，这两种情况分开处理）
         * @return icosdatas
         */
        public function DeleteByData($data, $force = false)
        {
            $havesubitem = 0;
            if (isset($data['contents'])) {
                foreach ($data['contents'] as $key => $value) {
                    $return = self::DeleteByData($value);
                    if (intval($return['delete']) < 1) {
                        $havesubitem = 1;
                    }
                    $data['contents'][$key] = $return;
                }
            }
            if ($data['success'] === true && !$havesubitem) {
                
                if ($data['icoid'] == $data['newdata']['icoid']) {
                    $data['newdata']['move'] = 1;
                } else {
                    $arr = IO::Delete($data['path']);
                    if ($arr['icoid']) $data['delete'] = 1;
                    else $data['success'] = $arr['error'];
                }
            }
            return $data;
        }
        
        //添加目录
        //$fname：目录名称;
        //$path：目录位置路径，如果是本地，$path 为pfid
        function CreateFolder($path, $fname, $perm = 0, $params = array(), $ondup = 'newcopy', $force = false)
        {
            $path = self::clean($path);//11
            $fname = self::name_filter($fname);
            if ($io = self::initIO($path)) {
                $return = $io->CreateFolder($path, $fname, $perm, $params, $ondup, $force);
                if (isset($return['icoarr'])) {
                    //Hook::listen('createFolder_after',$return['icoarr']);
                    Hook::listen('createafter_addindex_getvideo', $return['icoarr']);
                    Hook::listen('createafter_addindex', $return['icoarr']);
                }
                return $return;
            } else return false;
        }
        //添加多层目录
        //$fid：父级目录id;
        //$path：目录位置路径，如aaa/bbb/ccc
        function CreateFolderByPath($path, $fid, $bz = 'dzz', $params = array())
        {
            $path = self::clean($path);
            if ($io = self::initIO($bz)) {
                return $io->CreateFolderByPath($path, $fid, $params);
            } else return false;
        }
        
        /*将文件缓存到本地,并且返回本地的访问地址*/
        function cacheFile($data)
        {
            global $_G;
            $subdir = $subdir1 = $subdir2 = '';
            $subdir1 = date('Ym');
            $subdir2 = date('d');
            $subdir = $subdir1 . '/' . $subdir2 . '/';
            $target1 = 'dzzcache/' . $subdir . 'index.html';
            $target = 'dzzcache/' . $subdir . random(10);
            $target_attach = $_G['setting']['attachdir'] . $target1;
            $targetpath = dirname($target_attach);
            dmkdir($targetpath);
            if (file_put_contents($target, $data)) {
                return $target;
            } else {
                return false;
            }
        }
        
        //获取文件数据
        //$data：文件的信息数组
        //返回我文件data；
        function getFileContent($path)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) return $io->getFileContent($path);
            else return false;
        }
        //覆盖文件内容
        //$data：文件的信息数组
        //返回我文件data；
        function setFileContent($path, $data, $force = false, $nocover = true)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                if ($data = $io->setFileContent($path, $data, $force, $nocover)) {
                    $filedata = $data;
                    \Hook::listen('setfilecontent_after', $filedata);
                    return $data;
                } else {
                    return false;
                }
                
            } else return false;
        }
        
        //分片上传文件；
        //$path: 路径
        function multiUpload($file, $path, $filename, $attach = array(), $ondup = "newcopy")
        {
            $path = self::clean($path);
            $filename = self::name_filter($filename);
            if ($io = self::initIO($path)) return $io->multiUpload($file, $path, $filename, $attach, $ondup);
            else return false;
        }
        
        //添加文件
        //$fileContent：源文件数据;
        //$container：目标位置;
        //$bz：api;
        function upload($fileContent, $path, $filename)
        {
            $path = self::clean($path);
            $filename = self::name_filter($filename);
            if ($io = self::initIO($path)) {
                $return = $io->upload($fileContent, $path, $filename);

                return $return;
            } else return false;
        }
        
        function upload_by_content($fileContent, $path, $filename, $partinfo = array())
        {
            $path = self::clean($path);
            $filename = self::name_filter($filename);
            if ($io = self::initIO($path)) {
                $return = $io->upload_by_content($fileContent, $path, $filename, $partinfo);
                Hook::listen('createafter_addindex_getvideo', $return);
                Hook::listen('createafter_addindex', $return);
                return $return;
            } else return false;
        }
        public function uploadByStream($path,$filename,$file,$fid,$relativePath='',$nohook=0){
            $path = self::clean(urldecode($path));
            $name = self::name_filter(urldecode($filename));
            $relativePath = self::clean(urldecode($relativePath));
            if ($io = self::initIO($path)) {
                $return = $io->uploadByStream($path, $name, $file, $fid,$relativePath,$nohook);

                if ($return['icoarr'] && !$nohook) {
                    foreach ($return['icoarr'] as $v) {
                        $tmpdata = $v;
                        Hook::listen('createafter_addindex_getvideo', $tmpdata);
                        Hook::listen('createafter_addindex', $tmpdata);
                    }
                }
                return $return;
            } else return false;
        }
    
        //public function uploadStream($file, $name, $path, $relativePath = '', $content_range = '')
        public function uploadStream($file, $name, $appid, $pfid = '', $relativePath = '', $content_range = array(), $params = array())
        {
            $path = self::clean(urldecode($file));
            $name = self::name_filter(urldecode($name));
            $relativePath = self::clean(urldecode($relativePath));
            if ($io = self::initIO($path)) {
                $return = $io->uploadStream($file, $name, $appid,$pfid, $relativePath, $content_range,$params);
                if ($return['icoarr']) {
                    foreach ($return['icoarr'] as $v) {
                        $hookdata =  $v;
                        //Hook::listen('pichomeconvert',$tmpdata);
                        Hook::listen("addfileafter",$hookdata);
                    }
                }
                return $return;
            } else return false;
        }
        
        function Delete($path, $isdir = false)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                $return = $io->Delete($path, $isdir);
                return $return;
            } else return false;
        }
        
        //恢复文件
        function Recover($path, $combine = true, $force = false)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                return $io->Recover($path, $combine, $force);
            } else return false;
        }
        
        //获取不重复的目录名称
        public function getFolderName($fname, $path)
        {
            $path = self::clean($path);
            $fname = self::name_filter($fname);
            if ($io = self::initIO($path)) return $io->getFolderName($fname, $path);
            else return false;
        }
        
        
        public function download($paths, $filename = '', $checkperm = 'download', $param = array())
        {
            $paths = (array)$paths;
            $paths = self::clean($paths);
            if ($io = self::initIO($paths[0])) return $io->download($paths, $filename, $checkperm, $param);
            else return false;
        }
        
        public function localdownload($paths, $filename = '', $checkperm = 'download', $param = array())
        {
            $paths = (array)$paths;
            $paths = self::clean($paths);
            if ($io = self::initIO($paths[0])) return $io->localdownload($paths, $filename, $checkperm, $param);
            else return false;
        }
        
        public function getCloud($bz)
        {
            $bzarr = explode(':', $bz);
            $cloud = DB::fetch_first("select * from " . DB::table('connect') . " where bz='{$bzarr[0]}'");
            if ($cloud['type'] == 'pan') {
                $root = DB::fetch_first("select * from " . DB::table($cloud['dname']) . " where  id='{$bzarr[1]}'");
                if (!$root['cloudname']) $root['cloudname'] = $cloud['name'] . ':' . ($root['cusername'] ? $root['cusername'] : $root['cuid']);
            } elseif ($cloud['type'] == 'storage') {
                $root = DB::fetch_first("select * from " . DB::table($cloud['dname']) . " where id='{$bzarr[1]}'");
                $root['access_id'] = authcode($root['access_id'], 'DECODE', $root['bz']);
                if (!$root['cloudname']) $root['cloudname'] = $cloud['name'] . ':' . ($root['bucket'] ? $root['bucket'] : cutstr($root['access_id'], 4, $dot = ''));
            } elseif ($cloud['type'] == 'ftp') {
                $root = DB::fetch_first("select * from " . DB::table($cloud['dname']) . " where id='{$bzarr[1]}'");
            } elseif ($cloud['type'] == 'disk') {
                $root = DB::fetch_first("select * from " . DB::table($cloud['dname']) . " where id='{$bzarr[1]}'");
            } else {
                $root = DB::fetch_first("select * from " . DB::table($cloud['dname']) . " where id='{$bzarr[1]}'");
            }
            $root['cloudtype'] = $cloud['type'];
            return $root;
        }
        
        public function clean($str) {//清除路径
			if(is_array($str)){
				foreach($str as $key=> $value){
					$str[$key]=self::clean_path(str_replace(array( "\n", "\r", '../'), '', $value));
				}
			}else{
				$str= self::clean_path(str_replace(array( "\n", "\r", '../'), '', $str));
			}

			return $str;
		}
		private function clean_path($str){
			if(preg_match("/\.\.\//",$str)){
				$str=str_replace('../','',$str);
				return self::clean_path($str);
			}else{
				return $str;
			}
		}
        
        public function name_filter($name)
        {
            return str_replace(array('/', '\\', ':', '*', '?', '<', '>', '|', '"', "\n"), '', $name);
        }
        
        public function saveToAttachment($file_path, $filename, $tospace = 1, $width = 256, $height = 256, $deletesource = 1)
        {
            $md5 = md5_file($file_path);
            $filesize = filesize($file_path);
            if ($md5 && $attach = DB::fetch_first("select * from %t where md5=%s and filesize=%d", array('attachment', $md5, $filesize))) {
                $attach['filename'] = $filename;
                $pathinfo = pathinfo($filename);
                $ext = $pathinfo['extension'] ? $pathinfo['extension'] : '';
                $attach['filetype'] = $ext;
                if (in_array(strtolower($attach['filetype']), array('png', 'jpeg', 'jpg', 'gif', 'bmp'))) {
                    $attach['img'] = C::t('attachment')->getThumbByAid($attach, $width, $height);
                    $attach['isimage'] = 1;
                } else {
                    //$attach['img']=geticonfromext($ext);
                    $attach['isimage'] = 0;
                }
                //$attach['ffilesize']=formatsize($tattach['filesize']);
                if ($deletesource) @unlink($file_path);
                return $attach;
            } else {
                $target = self::getPath($filename);
                $pathinfo = pathinfo($filename);
                $ext = $pathinfo['extension'] ? $pathinfo['extension'] : '';
                if ($ext && in_array(strtolower($ext), getglobal('setting/unRunExts'))) {
                    $unrun = 1;
                } else {
                    $unrun = 0;
                }
                $filepath = getglobal('setting/attachdir') . $target;
                $handle = fopen($file_path, 'r');
                $handle1 = fopen($filepath, 'w');
                while (!feof($handle)) {
                    fwrite($handle1, fread($handle, 8192));
                }
                fclose($handle);
                fclose($handle1);
                if ($deletesource) @unlink($file_path);
                
                $filesize = filesize($filepath);
                $remote = 0;
                
                $attach = array(
                    
                    'filesize' => $filesize,
                    'attachment' => $target,
                    'filetype' => strtolower($ext),
                    'filename' => $filename,
                    'remote' => 1,
                    'copys' => 0,
                    'md5' => $md5,
                    'unrun' => $unrun,
                    'dateline' => $_G['timestamp'],
                );
                
                if ($attach['aid'] = C::t('attachment')->insert($attach, 1)) {
                    C::t('local_storage')->update_usesize_by_remoteid($attach['remote'], $attach['filesize']);
                    if ($tospace) dfsockopen(getglobal('localurl') . 'misc.php?mod=movespace&aid=' . $attach['aid'] . '&remoteid=0', 0, '', '', FALSE, '', 1);
                    if (in_array(strtolower($attach['filetype']), array('png', 'jpeg', 'jpg', 'gif', 'bmp'))) {
                        $attach['img'] = C::t('attachment')->getThumbByAid($attach['aid'], $width, $height);
                        $attach['isimage'] = 1;
                    } else {
                        $attach['img'] = geticonfromext($ext);
                        $attach['isimage'] = 0;
                    }
                    //$attach['ffilesize']=formatsize($tattach['filesize']);
                    return $attach;
                } else {
                    return false;
                }
            }
        }
        
        public function getPath($filename, $dir = 'dzz')
        {
            $pathinfo = pathinfo($filename);
            $ext = $pathinfo['extension'] ? ($pathinfo['extension']) : '';
            if ($ext && in_array(strtolower($ext), getglobal('setting/unRunExts'))) {
                $ext = 'dzz';
            }
            $subdir = $subdir1 = $subdir2 = '';
            $subdir1 = date('Ym');
            $subdir2 = date('d');
            $subdir = $subdir1 . '/' . $subdir2 . '/';
            $target1 = $dir . '/' . $subdir . 'index.html';
            $target = $dir . '/' . $subdir;
            $target_attach = getglobal('setting/attachdir') . $target1;
            $targetpath = dirname($target_attach);
            dmkdir($targetpath);
            return $target . date('His') . '' . strtolower(random(16)) . '.' . $ext;
        }
        //获取水印图地址
        public  function getwaterimg($path){
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                $return = $io->getwaterimg($path);
                return $return;
            } else return false;
        }
        //移动云端文件到上传区
        public function movetmpdataToattachment($path, $data)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                $return = $io->movetmpdataToattachment($path, $data);
                if ($return['icoarr']) {
                    foreach ($return['icoarr'] as $v) {
                        $hookdata =  $v;
                        //Hook::listen('pichomeconvert',$tmpdata);
                        Hook::listen("addfileafter",$hookdata);
                    }
                }
                return $return;
            } else return false;
        }
        
        //移动文件到下载缓冲区
        public function moveFileToDownload($path, $filepath)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                $return = $io->moveFileToDownload($path, $filepath);

                return $return;
            } else return false;
        }
        
        //移动缩略图到目标位置
        public function moveThumbFile($path, $filepath)
        {
            $path = self::clean($path);
            if ($io = self::initIO($path)) {
                $return = $io->moveThumbFile($path, $filepath);
                return $return;
            } else return false;
        }
        
    }

?>
