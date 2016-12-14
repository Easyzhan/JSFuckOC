function Bridge () {

    this.device = 'iPhone';
    this.deviceId = '';
    this.system = 'iOS';
    this.version = '5.3';
    this.longitude = 0;
    this.latitude = 0;
    
    this.test = function() {
        return 'It works!';
    }
    
    this.getDevice =  function() {
        return this.device;
    }
    
    this.setDevice = function(device) {
        this.device = device;
    }
    
    this.getDeviceId = function() {
        return this.deviceId;
    }
    
    this.setDeviceId = function(deviceId) {
        this.deviceId = deviceId;
    }
    
    this.getSystem = function() {
        return this.system;
    }
    
    this.setSystem = function(system) {
        this.system = system;
    }
    
    this.getVersion = function() {
        return this.version;
    }
    
    this.setVersion = function(version) {
        this.version = version;
    }
    
    // 经纬度
    this.setLatitude = function(latitude) {
        this.latitude = latitude;
    }
    
    this.getLatitude = function() {
        return this.latitude;
    }
    
    this.setLongitude = function(longitude) {
        this.longitude = longitude;
    }
    
    this.getLongitude = function() {
        return this.longitude;
    }

    // 错误提示
    this.showToast = function(errorMsg) {
        window.open('?tqmall_target_action=show_error_message' + '&errorMsg=' + errorMsg.toString(), '_self');
    }
    
    // pushId
    this.setPushId = function(pushId) {
        window.open('?tqmall_target_action=setPushId' + '&pushId=' + pushId.toString(), '_self');
    }

    // 消息弹窗
    this.showDialog = function(message) {
        window.open('?tqmall_target_action=show_message' + '&message=' + message.toString(), '_self');
    }

    // 跳转至主页
    this.pushToMainView = function() {
        window.open('?tqmall_target_action=pop_to_root_vc', '_self');
    }
    
    // 关闭当前页面
    this.finishCurrentView = function() {
        window.open('?tqmall_target_action=pop_to_previous_vc', '_self');
    }
    
    //关闭当前ViewController并在上一级ViewController执行指定js
    this.takeDataFinishCurrentView = function(jsStringToExecute) {
        window.open('?tqmall_target_action=pop_to_previous_vc_with_js_command&js_command=' + jsStringToExecute, '_self');
    }
    
    // 跳转至主页，并在新webViewController打开指定的url
    this.closeSurplusView = function(url) {
        window.open('?tqmall_target_action=pop_to_root_vc_open_url&url=' + url, '_self');
    }

    // 设置页面标题
    this.setTitle = function(title) {
        window.open('?tqmall_target_action=set_title' + '&title=' + title.toString(), '_self');
    }
    
    // 分享
    this.share = function(title, text, image, url) {
        window.open('?tqmall_target_action=share_to_sns' + '&title=' + title.toString() + '&text=' + text.toString() + '&image=' + image.toString() + '&url=' + url.toString(), '_self');
    }
    
    // 刷新当前页面
    this.refresh = function() {
        window.open('?tqmall_target_action=refresh', '_self');
    }
    
    // 重新加载所有页面
    this.reload = function() {
        window.open('?tqmall_target_action=reload', '_self');
    }
    
    // 获取经纬度
    this.getCoordinate = function(timestamp, callback) {
        window.open('?tqmall_target_action=get_coordinate' + '&timestamp=' + timestamp.toString() + '&callback=' + callback.toString(), '_self');
    }
    
    // 清除某个URL的缓存
    this.removeRequestCached = function(url) {
        window.open('?tqmall_target_action=remove_cached_response_url' + '&url=' + url.toString(), '_self');
    }
    
    // 清除所有的URL缓存
    this.removeAllRequestCached = function() {
        window.open('?tqmall_target_action=remove_all_cached_responses_url', '_self');
    }
    
    // 关闭当前登录页
    this.loginSuccess = function() {
        window.open('?tqmall_target_action=close_loginview', '_self')
    }
    
    // 跳转到登陆页
    this.pushToLoginView = function() {
        window.open('?tqmall_target_action=push_loginview', '_self')
    }
    
    /***************图片处理方法开始************/
    
    /**调用客户端选取照片，拍摄、图片压缩和存储
     * @param Integer customerId
     * @param String imgKey
     * @param String token
     * @return void
     */
    this.capture = function(customerId, imgKey, token) {
        var params = [
            '?tqmall_target_action=present_image_picker_view',
            'customerId=' + customerId,
            'imgKey=' + imgKey,
            'token=' + token,
            'callback=callback'
        ];
        window.open(params.join('&'), '_self');
    }
    
    /**查看大图
     * @param String token
     * @return void
     */
    this.scanPhoto = function(customerId, imgKey, token, url){
        var params = [
            '?tqmall_target_action=view_big_image',
            'customerId=' + customerId,
            'imgKey=' + imgKey,
            'token=' + token,
            'url=' + (url ? url : '')
        ];
        window.open(params.join('&'), '_self');
    }
    
    /**获取本地尚未上传照片张数， customerId为空时返回所有的未上传张数
     * @param Integer customerId
     */
    this.getLocalCount = function(customerId, callbackName) {
        window.open('?tqmall_target_action=get_local_shop_image_count&customerId=' + (customerId ? customerId : '') + '&callback=' + callbackName, '_self');
    }
    
    /**查看大图
     * @param String token
     * @return void
     */
    this.scanRemotePhoto = function(url){
        
    }
    
    /**查看缓存
     * @return void
     */
    this.checkPhone = function() {
        
    }
    
    /**
     * 查看本地相册
     * @return void
     */
    this.localPhotos = function() {
        window.open('?tqmall_target_action=local_photos', '_self');
    }
    
    /**
     * 根据token组成的json数组上传照片
     * @param String tokenJsonString eg:'["token1","token2",......]'
     * @return void
     */
    this.upload = function(tokenJsonString) {
        window.open('?tqmall_target_action=upload_shop_imgs&tokenJsonString=' + tokenJsonString, '_self');
    }
    
    /**
     * 获取本地图片信息
     */
    this.freshPhotoInfo = function(customerId) {
        window.open('?tqmall_target_action=get_local_photo_info&customerId=' + customerId, '_self');
    }
    
    /***************图片处理方法结束************/
    
    // 弹出native的PopDatePickerView
    this.popDatePicker = function(isShowTime, callbackName) {
        window.open('?tqmall_target_action=pop_date_picker&isShowTime=' + isShowTime.toString() + '&callback=' + callbackName.toString(), '_self');
    }
    
    this.setTabBarItems = function (tabBarItemsString) {
        window.open('?tqmall_target_action=set_tab_bar_items&items=' + tabBarItemsString, '_self');
    }
    
    this.setActionBarLeftBtn = function(jsonString) {
        window.open('?tqmall_target_action=set_nav_item_left&item=' + jsonString, '_self');
    }
    
    // 显示左导航按钮
    this.showActionBarLeftBtn = function() {
        window.open('?tqmall_target_action=show_navigation_item_left_bar_button', '_self');
    }
    
    // 隐藏左导航按钮
    this.hideActionBarLeftBtn = function() {
        window.open('?tqmall_target_action=hide_navigation_item_left_bar_button', '_self');
    }
    
    // 跳转到二维码/条形码扫描页面
    this.goScanView = function(callbackName) {
        window.open('?tqmall_target_action=present_scan_view_controller&callback=' + callbackName, '_self');
    }
    
    // 复制内容到系统剪切板
    this.copyToClipboard = function(content) {
        window.open('?tqmall_target_action=copy_to_clipboard&content=' + content, '_self');
    }
    
    // 获取剪切板内容
    this.getFromClipboard = function(callbackName) {
        window.open('?tqmall_target_action=get_from_clipboard&callback=' + callbackName, '_self');
    }
    
    // 弹出省市区街道选择器
    this.popLocationPicker = function (isShowEmptyItem ,type, callbackName, selectedItemIds) {
        if (typeof selectedItemIds == "undefined") {
            selectedItemIds = "";
        }
        isShowEmptyItem = isShowEmptyItem ? 1 : 0;
        window.open('?tqmall_target_action=pop_location_picker&type=' + type + '&callback=' + callbackName + '&selectedItemIds='+selectedItemIds + '&isShowEmptyItem=' + isShowEmptyItem, '_self');
    }
    
    // 打开门店地图 ViewController
    this.openMapView = function () {
        window.open('?tqmall_target_action=open_map_view', '_self');
    }
    
    /**
     * 设置 openId sessionId
     */
    this.setSessionId = function(sharedSid,sessionId){
        window.open('?tqmall_target_action=setSessionId&sessionId='+sessionId+'&sharedSid='+sharedSid, '_self');
    }
    
    //设置openid sharedSid
    this.setSessionId = function(sharedSid){
        window.open('?tqmall_target_action=setSessionId&sharedSid='+sharedSid, '_self');
    }
    
    //文件上传-控件
    this.takePhoto=function(spacePath){
        window.open('?tqmall_target_action=takePhoto&spacePath='+spacePath, '_self');
    }
}

var Tqmall = new Bridge();
