function getQueryVariable(variable)
{
    let query = window.location.search.substring(1);
    let vars = query.split("&");
    for (let i=0;i<vars.length;i++) {
        let pair = vars[i].split("=");
        if(pair[0] == variable){return pair[1];}
    }
    return(false);
}

// alert(getQueryVariable('path'));
// alert(getQueryVariable('title'));
// alert(getQueryVariable('description'));
// alert(getQueryVariable('country'));
// alert(getQueryVariable('city'));
//  alert(getQueryVariable('content'));

let mimageId=getQueryVariable('imageId');


if(mimageId!=false)
    modify();



//let filepath='../upfile/'+path;
//let file = new File(,)
function modify() {
    let up_button=document.getElementById("up_button");
    // let title=document.getElementsByName('upload_pic_title');
    // let description=document.getElementsByName('upload_pic_description');
    // let country=document.getElementById('first');
    // let city=document.getElementById('second');
    // let content=document.getElementsByName('upload_pic_theme')[0];

    document.getElementById("up_line").style.display = "none";
    // let image = document.getElementById('ready_to_up_pics');
    // image.setAttribute('src', '../upfile/' + mpath);
    up_button.required = false; //设置选择文件不一定要选
    //title[0].value = decodeURI(mtitle);
    //encodeURI(title[0].value);

    //description[0].value = decodeURI(mdescription); //decode


    let submit=document.getElementById('upload_submit');
    submit.innerHTML='Modify';
    let page=document.getElementsByClassName('up_til')[0];
    page.innerHTML='MODIFY';
    let form=document.getElementsByTagName('form')[0];
    form.setAttribute('action','modify?imageId='+mimageId);

}