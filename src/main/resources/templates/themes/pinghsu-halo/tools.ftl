<#include "header.ftl">
<@header title="工具 | ${options.blog_title!}" keywords="${options.seo_keywords!}" description="${options.seo_desc!}"></@header>
<script>
    function factor(n) {
        if (n<=0 || n!=Math.floor(n))
            return [];
        ret=[];
        i=2;
        m=n
        while (i*i<=n) {
            while (m%i==0) {
                m/=i
                ret.push(i)
            }
            if (m==1)
                break;
            i++;
        }
        if (m!=1) {
            ret.push(m)
        }
        return ret;
    }
    function show() {

        var input_n=document.getElementById("number").value;

        if ( !/^(\-|\+)?([0-9]+)$/.test(input_n) ){

            alert("Error!");

            return false;

        }

        var n=parseInt(input_n)

        if (n<=1 || n>=100000000000) {

            alert("Error!");

            return false;

        }

        t=document.createElement("p");

        f=factor(n);

        console.log(f);

        s=n+" = "

        for (i=0; i<f.length; i++) {

            if (i>0) s+=" * "

            s+=f[i]

        }

        console.log(s)

        t.innerHTML=s;

        var result=document.getElementById("result");

        while (result.firstChild) result.removeChild(result.firstChild);

        result.appendChild(t)

        return false;

    }
    function translation(){
        var url="/tools/translation";
        var keyword =$("#keyword").val();
        $.post(url,{"keyword":keyword},function (data) {
            console.log(data);
            console.log("____________");
            console.log(data.translation);
           var basic= data.basic;//词义，基本词典,查词时才有
           var web= data.web;//词义，网络释义，该结果不一定存在
           var l= data.l;//源语言和目标语言,一定存在
           var us= basic.us-phonetic//美式音标，英文查词成功，一定存在
           var phonetic= basic.phonetic//默认音标，默认是英式音标，英文查词成功，一定存在
           var uk= basic.uk-phonetic//英式音标，英文查词成功，一定存在
           var ukSpeech= basic.uk-speech//英式音标，英文查词成功，一定存在
           var usSpeech= basic.us-speech//美式发音，英文查词成功，一定存在

            if (basic!=null){
                var list=  basic.explains;//基本释义
                var str="";
                for (var i = 0; i < list.length; i++) {
                    var listElement = list[i];
                    str+="  "+listElement;
                }
            } else {
                str="无法翻译火星文"
            }

         $("#result2").html(str);
        },"json")
    }
</script>
<div class="main-content archive-page clearfix">
    <div class="categorys-item">
        <h1>整数分解<=100000000000</h1>
        <form id="form1" onSubmit="return show();">

            <input type="text" id="number"/>

            <input type="submit" placeholder="123456" />

        </form>
        <div id="result">
        </div>
    </div>

    <div class="categorys-item">
        <h1>翻译</h1>
            <input type="text" id="keyword"/>
        <a onclick="translation()">提交</a>
        <div id="result2">

        </div>
    </div>
</div>
<#include "footer.ftl">