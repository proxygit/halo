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
        document.getElementById("tab1").style.display="";
        var url="/tools/translation";
        var keyword =$("#text").val();

        $("#explains").html('');
        $("#web").html('')
        $("#phonetic").html('')
       if (keyword!=null&&keyword!=''){
           $.post(url,{"keyword":keyword},function (data) {
               //console.log(data);
               var basic= data.basic;//词义，基本词典,查词时才有
               var web= data.web;//词义，网络释义，该结果不一定存在

               if (basic!=null){
                   $("#basic").html(basic)
                   var phonetic= basic.phonetic//默认音标，默认是英式音标，英文查词成功，一定存在
                   if (phonetic!=null){
                       $("#phonetic").html(phonetic)
                       //console.log(phonetic);
                   }
                   var list=  basic.explains;//基本释义
                   var str="";
                   for (var i = 0; i < list.length; i++) {
                       var listElement = list[i];
                       str+="  "+listElement;
                   }
               } else {
                   str=data.translation;//词查不到就查句子
               }

               if (web!=null){
                   $("#web").html(web)
               }

               $("#explains").html(str);
           },"json")
       }else {
           console.log("调皮了，大兄弟😝");
       }
    }
</script>
    <script>
        var observe;
        if (window.attachEvent) {
            observe = function (element, event, handler) {
                element.attachEvent('on'+event, handler);
            };
        }
        else {
            observe = function (element, event, handler) {
                element.addEventListener(event, handler, false);
            };
        }
        function init () {
            var text = document.getElementById('text');
            function resize () {
                text.style.height = 'auto';
                text.style.height = text.scrollHeight+'px';
            }
            /* 0-timeout to get the already changed text */
            function delayedResize () {
                window.setTimeout(resize, 0);
            }
            observe(text, 'change',  resize);
            observe(text, 'cut',     delayedResize);
            observe(text, 'paste',   delayedResize);
            observe(text, 'drop',    delayedResize);
            observe(text, 'keydown', delayedResize);

            text.focus();
            text.select();
            resize();
        }
    </script>
    <style>
        textarea {
            width:555px;
            border: 1px none darkslategray;
            overflow: auto;
            padding: 0;
            outline: none;
            background-color: blanchedalmond;
        }

         .input {
             background-color:blanchedalmond;
         }

    </style>
<body onload="init();">
<div class="main-content archive-page clearfix">
    <div class="categorys-item">
        <h1>整数分解<=100000000000</h1>
        <form id="form1" onSubmit="return show();">

            <input class="input" onkeyup="this.value=this.value.replace(/\D/g,'')" autocomplete="off" type="text" id="number"/>

            <input type="submit"  />

        </form>
        <div id="result">
        </div>
    </div>

    <div class="categorys-item">
        <h1>翻译</h1>

        <textarea rows="1"  id="text" placeholder="翻译一下"></textarea>

        <#-- <input type="text" id="keyword"/>-->
        <input type="submit" onclick="translation()" />
    </div>
    <div id="tab1"  style="display: none" class="post-list-item">
        <div class="post-content" id="explains" ></div>
        <div class="post-content" id="basic"></div>
        <div  class="post-content" id="phonetic"> </div>
        <div class="post-content" id="web"> </div>
    </div>
</div>

</body>

<#include "footer.ftl">