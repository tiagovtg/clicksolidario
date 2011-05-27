$(document).ready(function() {
    $("#login").toggle(function(){
        $("#divLogin").slideDown('slow');
    },function(){
        $("#divLogin").slideUp('slow');
    });
    $("#entidade").toggle(function(){
        $("#divEntidade").slideDown('slow');
    },function(){
        $("#divEntidade").slideUp('slow');
    });
});

//Aumenta e reduz o tamanho da fonte
$(document).ready(function(){

    var fonte = 14;
    $("#aumenta_fonte").click(function(){
        if (fonte<18){
            fonte = fonte+1;
            $("#colunaDireita").css({"font-size" : fonte+"px"});
            $("#cadastro").css({"font-size" : fonte+"px"});
        }
    });
    $("#reduz_fonte").click(function(){
        if (fonte>9){
            fonte = fonte-1;
            $("#colunaDireita").css({"font-size" : fonte+"px"});
            $("#cadastro").css({"font-size" : fonte+"px"});
        }
    });
});