

$(function () {
    $('form').bootstrapValidator({
        message: 'This value is not valid',
        live: 'submitted', //验证时机，enabled是内容有变化就验证（默认）
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            upload_pics: {
                verbose: true,
                validators: {

                    file: {
                        extension: 'png,jpg,jpeg,gif',
                        type: 'image/png,image/jpg,image/jpeg,image/gif',
                        message: '文件格式错误，请重新选择图片格式为png/jpg/jpeg/gif'
                    }
                }
            }
        }

    });


});