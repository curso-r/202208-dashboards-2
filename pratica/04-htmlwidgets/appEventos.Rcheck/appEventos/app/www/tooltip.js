var target_ano = document.getElementById("filtro_ano");
var target_regiao = document.getElementById("filtro_regiao");

tippy('#tippy_ui_1-pesquisar', {
  content: 'Clique aqui!',
  triggerTarget: [target_ano, target_regiao],
  trigger: "click",
  hideOnClick: false,
  placement: "right"
});

var botao = document.getElementById("tippy_ui_1-pesquisar");

botao.onclick = function() {
  tippy.hideAll();
}
