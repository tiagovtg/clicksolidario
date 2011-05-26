/**
 * Pesquisa um endereço conforme o CEP
 * contribuição Isac Jaco.
 * @require jquery
 */

/* URL do seviço */
var serviceURL = "http://republicavirtual.com.br/web_cep.php";
//var serviceURL = "http://localhost/Address4CEP/php/address.php";

/* ID do campo endereco */
var inpEnd = "endereco";

/* ID do campo cidade */
var inpCidade = "cidade";

/* ID do campo bairro*/
var inpBairro = "bairro";

/* ID do campo bairro */
var inpEstado = "estado";

/* ID do campo Endereço */
var inpEndereco = "endereco";

$(function(){
    var format = "json";
    $("#cep").keyup(onKeyUp);
	
    /**
* onKeyUp()
* 
* Verifica se foram digitados 8 caracteres, se digitado busca o endereço do cep e preenche os campos
*/
    function onKeyUp (){
        var $this = $(this);
        var ereg = new RegExp(/([0-9]{2}).([0-9]{3}).([0-9]{3})/);
        if(ereg.test($this.val()))
        {
            var result = ereg.exec($this.val());
            var cep = result[1]+result[2]+result[3];
			
            //Função de callback caso sucesso
            var callback = function(result){
                $("#"+inpEnd).val(result.logradouro);
                $("#"+inpBairro).val(result.bairro);
                $("#"+inpCidade).val(result.cidade);
                $("#"+inpEstado).val(result.uf);
                $("#"+inpEndereco).val(result.endereco);
            };
			
            //Função callback caso erro
            var error = function (data){
                data;
            };
			
            $.ajaxSetup({
                url: serviceURL,
                type: "GET",
                method: "GET",
                dataType:"json",
                success: callback,
                error  : error
            });

            $.ajax({
                data: "cep="+cep+"&formato="+format
            });
        }
    }
});
