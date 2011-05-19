jQuery(function(){

    /* função para adicionar nova linha dentro do form, usandos nested forms */
    jQuery('a.add_child').live("click", function() {
        var association = jQuery(this).attr('data-association');
        var template = jQuery(this).prev().html();
        var regexp = new RegExp('new_' + association, 'g');
        var new_id = new Date().getTime();
        jQuery(this).parent().before(template.replace(regexp, new_id));
        Mascaras();
        return false;
    });

    /* função para removes nova linha dentro do form, usandos nested forms */
    jQuery('a.remove_child').live('click', function() {
        var hidden_field = jQuery(this).prev('input[type=hidden]')[0];
        if(hidden_field) {
            hidden_field.value = '1';
        }
        jQuery(this).parents('.fields:first').hide();
        return false;
    });

    /* mascaras*/
    Mascaras();
    function Mascaras($){
        jQuery(".cpf").setMask({
            mask: '999.999.999-99'
        });
        jQuery(".cnpj").setMask({
            mask: '99.999.999/9999-99'
        });
        jQuery(".cep").setMask({
            mask: '99.999-999'
        });
        jQuery(".telefone").setMask({
            mask: '9999-9999'
        });
        jQuery(".ddd").setMask({
            mask: '99'
        });
    }

    /* funçoes*/
    function SomenteLetras(e){
        var tecla = (window.event) ? event.keyCode : e.which;
        var palavra = String.fromCharCode(tecla);

        var caracteresValidos = 'àèìòùâêîôûäëïöüáéíóúãõÀÈÌÒÙÂÊÎÔÛÄËÏÖÜÁÉÍÓÚÃÕ';
        caracteresValidos = caracteresValidos + 'abcdefghijklmnopqrstuvxywz';
        caracteresValidos = caracteresValidos + 'ABCDEFGHIJKLMNOPQRSTUVXYWZ';
        caracteresValidos = caracteresValidos + '´`^¨~ç';

        if (caracteresValidos.indexOf(palavra) != -1) {
            return true;
        }
        else {
            if ((tecla == 32) || (tecla == 0)) // 32 spaço, 0 TAB.
                return true;
            else {
                if (tecla != 8)
                    return false;
                else
                    return true;
            }
            return false;
        }
    }

    function letrasNumeros(e){
        var tecla = (window.event) ? event.keyCode : e.which;
        var palavra = String.fromCharCode(tecla);

        var caracteresValidos = '0123456789';

        if (caracteresValidos.indexOf(palavra) != -1) {
            return true;
        }
        else {
            if (SomenteLetras(e)) {
                return true;
            }
            return false;
        }
    }

    function SomenteEmail(e){
        var tecla = (window.event) ? event.keyCode : e.which;
        var palavra = String.fromCharCode(tecla);

        var caracteresValidos = 'abcdefghijklmnopqrstuvxywz';
        caracteresValidos = caracteresValidos + 'ABCDEFGHIJKLMNOPQRSTUVXYWZ';
        caracteresValidos = caracteresValidos + '.@_-';
        caracteresValidos = caracteresValidos + '0123456789';

        if (caracteresValidos.indexOf(palavra) != -1) {
            return true;
        }
        else {
            if ((tecla == 32) || (tecla == 0)) // 32 spaço, 0 TAB.
                return true;
            else {
                if (tecla != 8)
                    return false;
                else
                    return true;
            }
            return false;
        }
    }


    /* adicionar mais js daqui */

    function buscaSolidaria(){
        // chama o metodo buscaSolidaria na controler portal.
        jQuery.ajax({
            type: "POST",
            url: "busca_solidaria",
            data: {
                filtro: jQuery("#filtroNome").val(),
                 query: jQuery('#buscaSolidaria-campo').text()
            },
            success: function(){
                //recarrega a pagina.
                //location.reload()
                alert('sucesso!')
            }
        });
    }
});


