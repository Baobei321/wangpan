<?php
if(!defined('IN_OAOOA')) {
    exit('Access Denied');
}
@set_time_limit(0);
dfsockopen(getglobal('localurl'). 'misc.php?mod=doupdatePreviewthumb',0, '', '', false, '', 1);