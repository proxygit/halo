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
        var keyword =$("#keyword").val();
        $("#explains").html('');
        $("#web").html('')
        $("#phonetic").html('')
        $.post(url,{"keyword":keyword},function (data) {
            //console.log(data);
            var basic= data.basic;//词义，基本词典,查词时才有
           var web= data.web;//词义，网络释义，该结果不一定存在

            if (basic!=null){
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

            var tSpeakUrl=data.tSpeakUrl;
            var speakUrl=data.speakUrl;
            $('#tSpeakUrl').attr('src',tSpeakUrl);
            $('#speakUrl').attr('src',tSpeakUrl);
            console.log(tSpeakUrl);
             console.log(speakUrl);
            $("#explains").html(str);
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
        <a onclick="translation()">提交</a><br/>
      <#--  基本:<div id="explains"></div><br/>
        音标:<div id="phonetic"></div><br/>
        网络:<div id="web"></div><br/>-->
    </div>
    <div id="tab1"  style="display: none" class="post-list-item">
        <div class="post-list-item-container">
            <div class="item-label">
                <div id="explains" class="item-title"></div>
                <div class="item-title"  id="phonetic"> </div>
                <div class="item-title"  id="web"> </div>
                <audio id="fry_audio" src="" controls="controls">
                </audio>
                <audio id="speakUrl" src="" controls="controls">
                </audio>
            </div>
        </div>
    </div>
</div>
<#--<div class="main-content archive-page clearfix">
    <div class="categorys-item">
                <div class="categorys-item">
                        <div class="post-lists">
                            <div class="post-lists-body">
                              <!--&ndash;&gt;

                                <!--&ndash;&gt;
                            </div>
                        </div>
                </div>
    </div>
</div>-->
<#include "footer.ftl">