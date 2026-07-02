<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>Livro-Caixa · Controle de Gastos</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,500;9..144,600;9..144,700&family=Space+Mono:wght@400;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  :root{
    --paper: #efead9;
    --paper-2: #e8e2cd;
    --ink: #23301f;
    --ink-soft: #55604c;
    --forest: #2f5233;
    --forest-deep: #203a24;
    --line: #c3cbb1;
    --margin-red: #b5544a;
    --stamp-green: #3b6e44;
    --stamp-red: #a23b2e;
    --gold: #a9843c;
    --card-bg: #f6f3e6;
    --shadow: rgba(35,48,31,0.18);
  }

  *{box-sizing:border-box;}
  html,body{margin:0;padding:0;}

  body{
    background:
      repeating-linear-gradient(var(--paper) 0px, var(--paper) 27px, var(--line) 28px),
      var(--paper);
    color:var(--ink);
    font-family:'Inter', sans-serif;
    min-height:100vh;
    padding-bottom:80px;
  }

  body::before{
    content:'';
    position:fixed;
    top:0; bottom:0; left:38px;
    width:2px;
    background:var(--margin-red);
    opacity:0.35;
    z-index:0;
    pointer-events:none;
  }

  @media (max-width:640px){
    body::before{ left:20px; }
  }

  .wrap{
    max-width:920px;
    margin:0 auto;
    padding:0 24px;
    position:relative;
    z-index:1;
  }

  /* ---------- Header ---------- */
  header{
    padding:44px 0 24px 48px;
  }
  @media (max-width:640px){ header{ padding-left:30px; } }

  .eyebrow{
    font-family:'Space Mono', monospace;
    font-size:11px;
    letter-spacing:0.18em;
    text-transform:uppercase;
    color:var(--forest);
    margin:0 0 6px 0;
  }

  h1{
    font-family:'Fraunces', serif;
    font-optical-sizing:auto;
    font-weight:600;
    font-size:clamp(32px, 5vw, 46px);
    margin:0 0 6px 0;
    color:var(--forest-deep);
    letter-spacing:-0.01em;
  }

  .sub{
    color:var(--ink-soft);
    font-size:14.5px;
    max-width:520px;
    line-height:1.5;
  }

  /* ---------- Summary cards ---------- */
  .summary{
    display:grid;
    grid-template-columns:repeat(3, 1fr);
    gap:14px;
    padding:0 0 8px 48px;
  }
  @media (max-width:640px){
    .summary{ grid-template-columns:1fr; padding-left:30px; }
  }

  .sum-card{
    background:var(--card-bg);
    border:1px solid var(--line);
    border-radius:2px;
    padding:18px 18px 16px;
    box-shadow:0 2px 0 var(--shadow);
    position:relative;
  }
  .sum-card .lbl{
    font-family:'Space Mono', monospace;
    font-size:10.5px;
    letter-spacing:0.1em;
    text-transform:uppercase;
    color:var(--ink-soft);
    margin-bottom:8px;
  }
  .sum-card .val{
    font-family:'Space Mono', monospace;
    font-size:26px;
    font-weight:700;
    color:var(--forest-deep);
  }
  .sum-card.positivo .val{ color:var(--stamp-green); }
  .sum-card.negativo .val{ color:var(--stamp-red); }
  .sum-card .val small{ font-size:14px; font-weight:400; }

  /* ---------- Accounts row ---------- */
  section.contas{
    padding:28px 0 8px 48px;
  }
  @media (max-width:640px){ section.contas{ padding-left:30px; } }

  .section-title{
    font-family:'Space Mono', monospace;
    font-size:11px;
    letter-spacing:0.14em;
    text-transform:uppercase;
    color:var(--ink-soft);
    margin:0 0 12px 0;
    display:flex;
    align-items:center;
    gap:10px;
  }
  .section-title::after{
    content:'';
    flex:1;
    height:1px;
    background:var(--line);
  }

  .contas-grid{
    display:grid;
    grid-template-columns:repeat(3, 1fr);
    gap:14px;
  }
  @media (max-width:640px){ .contas-grid{ grid-template-columns:1fr; } }

  .conta-card{
    background:var(--card-bg);
    border:1px solid var(--line);
    border-left:4px solid var(--forest);
    padding:14px 16px;
    border-radius:2px;
  }
  .conta-card .nome{
    font-weight:600;
    font-size:14px;
    color:var(--forest-deep);
    margin-bottom:2px;
  }
  .conta-card .row{
    display:flex;
    justify-content:space-between;
    align-items:baseline;
    margin-top:8px;
    font-size:12.5px;
    color:var(--ink-soft);
  }
  .conta-card .row .n{
    font-family:'Space Mono', monospace;
  }
  .conta-card .saldo-atual{
    font-family:'Space Mono', monospace;
    font-size:19px;
    font-weight:700;
    margin-top:4px;
  }
  .conta-card input.saldo-inicial-input{
    font-family:'Space Mono', monospace;
    background:transparent;
    border:none;
    border-bottom:1px dashed var(--line);
    text-align:right;
    width:80px;
    font-size:12.5px;
    color:var(--ink);
    padding:0 2px;
  }
  .conta-card input.saldo-inicial-input:focus{
    outline:none;
    border-bottom:1px solid var(--forest);
  }

  /* ---------- Ledger table ---------- */
  section.lancamentos{
    padding:32px 0 0 48px;
  }
  @media (max-width:640px){ section.lancamentos{ padding-left:30px; } }

  .toolbar{
    display:flex;
    gap:8px;
    align-items:center;
    margin-bottom:2px;
    flex-wrap:wrap;
  }
  select.filtro{
    font-family:'Inter', sans-serif;
    font-size:12.5px;
    padding:6px 8px;
    border:1px solid var(--line);
    background:var(--card-bg);
    color:var(--ink);
    border-radius:2px;
  }

  .ledger{
    margin-top:14px;
  }

  .l-head{
    display:grid;
    grid-template-columns: 1fr 110px 90px 90px 32px;
    gap:10px;
    padding:0 12px 8px;
    font-family:'Space Mono', monospace;
    font-size:10px;
    letter-spacing:0.1em;
    text-transform:uppercase;
    color:var(--ink-soft);
    border-bottom:1px solid var(--ink-soft);
  }
  @media (max-width:640px){
    .l-head{ display:none; }
  }

  .l-row{
    display:grid;
    grid-template-columns: 1fr 110px 90px 90px 32px;
    gap:10px;
    align-items:center;
    padding:10px 12px;
    border-bottom:1px solid var(--line);
    transition:background .15s;
  }
  .l-row:hover{ background:rgba(47,82,51,0.05); }

  @media (max-width:640px){
    .l-row{
      grid-template-columns: 1fr auto;
      grid-template-areas:
        "nome nome"
        "conta valor"
        "status del";
      row-gap:6px;
      background:var(--card-bg);
      border:1px solid var(--line);
      border-radius:2px;
      margin-bottom:10px;
    }
    .l-row .c-nome{ grid-area:nome; }
    .l-row .c-conta{ grid-area:conta; }
    .l-row .c-valor{ grid-area:valor; text-align:right; }
    .l-row .c-status{ grid-area:status; }
    .l-row .c-del{ grid-area:del; justify-self:end; }
  }

  .c-nome input{
    width:100%;
    border:none;
    background:transparent;
    font-family:'Inter', sans-serif;
    font-size:14px;
    color:var(--ink);
    padding:4px 2px;
  }
  .c-nome input:focus{ outline:none; border-bottom:1px solid var(--forest); }

  select.c-conta-select{
    width:100%;
    font-family:'Inter', sans-serif;
    font-size:12.5px;
    padding:5px 4px;
    border:1px solid transparent;
    background:transparent;
    color:var(--ink-soft);
    border-radius:2px;
  }
  select.c-conta-select:hover{ border-color:var(--line); }

  input.c-valor-input{
    width:100%;
    text-align:right;
    font-family:'Space Mono', monospace;
    font-size:14px;
    font-weight:700;
    border:none;
    background:transparent;
    color:var(--ink);
    padding:4px 2px;
  }
  input.c-valor-input:focus{ outline:none; border-bottom:1px solid var(--forest); }

  .stamp{
    font-family:'Space Mono', monospace;
    font-size:10px;
    font-weight:700;
    letter-spacing:0.08em;
    text-transform:uppercase;
    padding:4px 9px;
    border-radius:3px;
    border:1.5px solid currentColor;
    display:inline-block;
    cursor:pointer;
    transform:rotate(-2deg);
    user-select:none;
    background:transparent;
  }
  .stamp.pago{ color:var(--stamp-green); }
  .stamp.pendente{ color:var(--stamp-red); transform:rotate(1.5deg); }

  .btn-del{
    background:none;
    border:none;
    color:var(--ink-soft);
    cursor:pointer;
    font-size:16px;
    line-height:1;
    padding:4px;
    opacity:0.55;
  }
  .btn-del:hover{ opacity:1; color:var(--stamp-red); }

  .add-row{
    margin-top:14px;
    padding:0 12px;
  }
  .btn-add{
    font-family:'Space Mono', monospace;
    font-size:12px;
    letter-spacing:0.05em;
    background:var(--forest);
    color:var(--paper);
    border:none;
    padding:10px 16px;
    border-radius:2px;
    cursor:pointer;
  }
  .btn-add:hover{ background:var(--forest-deep); }

  .empty{
    padding:30px 12px;
    text-align:center;
    color:var(--ink-soft);
    font-size:13.5px;
  }

  /* ---------- Footer / backup ---------- */
  footer{
    margin-top:44px;
    padding:20px 0 0 48px;
    display:flex;
    gap:10px;
    flex-wrap:wrap;
  }
  @media (max-width:640px){ footer{ padding-left:30px; } }

  .btn-ghost{
    font-family:'Space Mono', monospace;
    font-size:11.5px;
    background:transparent;
    color:var(--ink-soft);
    border:1px solid var(--line);
    padding:8px 12px;
    border-radius:2px;
    cursor:pointer;
  }
  .btn-ghost:hover{ border-color:var(--forest); color:var(--forest); }

  .note{
    font-size:11.5px;
    color:var(--ink-soft);
    padding:10px 0 0 48px;
    max-width:560px;
    line-height:1.5;
  }
  @media (max-width:640px){ .note{ padding-left:30px; } }

  #file-input{ display:none; }

  /* ---------- Ajuste fino: iPhone / telas estreitas (até 430px) ---------- */
  @media (max-width:430px){
    body{ padding-bottom:100px; }
    body::before{ left:16px; }

    .wrap{ padding:0 14px; }

    header{ padding:28px 0 18px 22px; }
    h1{ font-size:28px; }
    .sub{ font-size:13.5px; }
    .eyebrow{ font-size:10px; letter-spacing:0.14em; }

    .summary{
      grid-template-columns:1fr 1fr;
      padding-left:22px;
      padding-right:0;
      gap:10px;
    }
    .sum-card{ padding:14px 14px 12px; }
    .sum-card .val{ font-size:20px; }
    .sum-card .lbl{ font-size:9.5px; }

    section.contas{ padding:22px 0 4px 22px; }
    section.lancamentos{ padding:24px 0 0 22px; }
    .section-title{ font-size:10px; }

    .contas-grid{ gap:10px; }
    .conta-card{ padding:12px 14px; }
    .conta-card .saldo-atual{ font-size:17px; }
    .conta-card input.saldo-inicial-input{ font-size:13px; width:70px; }

    .toolbar{ gap:6px; }
    select.filtro{
      flex:1;
      min-width:0;
      font-size:12px;
      padding:8px 6px;
    }

    .l-row{
      padding:12px;
      grid-template-columns: 1fr auto;
    }
    .c-nome input{ font-size:15px; padding:6px 2px; }
    input.c-valor-input{ font-size:15px; padding:6px 2px; }
    select.c-conta-select{ font-size:13px; padding:6px 2px; }

    .stamp{
      padding:6px 11px;
      font-size:10.5px;
    }
    .btn-del{
      font-size:19px;
      padding:6px 8px;
    }

    .add-row{ padding:0; }
    .btn-add{
      width:100%;
      padding:14px 16px;
      font-size:13px;
      text-align:center;
    }

    footer{
      padding:18px 14px 0;
      margin-top:32px;
      gap:8px;
    }
    .btn-ghost{
      flex:1 1 calc(50% - 4px);
      padding:11px 10px;
      font-size:11px;
      text-align:center;
    }

    .note{ padding:12px 14px 0; font-size:11px; max-width:none; }

    .sync-card{
      margin:16px 14px 0;
      padding:14px;
      max-width:none;
    }
    .sync-row{ flex-direction:column; align-items:stretch; }
    input#sync-url{ font-size:13px; padding:10px; }
    #btn-sync-save{ width:100%; padding:11px; text-align:center; }
    .sync-actions{ flex-direction:column; }
    .sync-actions .btn-ghost{ flex:1 1 auto; width:100%; }
  }

  /* garante alvo de toque confortável em qualquer tela estreita */
  @media (hover:none) and (pointer:coarse){
    .stamp, .btn-del, .btn-ghost, .btn-add, select.filtro, select.c-conta-select{
      min-height:38px;
      display:inline-flex;
      align-items:center;
      justify-content:center;
    }
    .c-nome input, input.c-valor-input{ min-height:36px; }
  }

  /* ---------- Sync card ---------- */
  .sync-card{
    margin:20px 48px 0;
    background:var(--card-bg);
    border:1px solid var(--line);
    border-left:4px solid var(--gold);
    border-radius:2px;
    padding:16px 18px;
    max-width:600px;
  }
  @media (max-width:640px){ .sync-card{ margin-left:30px; margin-right:24px; } }

  .sync-card .lbl{
    font-family:'Space Mono', monospace;
    font-size:10.5px;
    letter-spacing:0.1em;
    text-transform:uppercase;
    color:var(--ink-soft);
    margin-bottom:10px;
  }
  .sync-row{
    display:flex;
    gap:8px;
    flex-wrap:wrap;
    align-items:center;
  }
  input#sync-url{
    flex:1;
    min-width:200px;
    font-family:'Space Mono', monospace;
    font-size:12px;
    padding:8px 10px;
    border:1px solid var(--line);
    border-radius:2px;
    background:#fff;
    color:var(--ink);
  }
  input#sync-url:focus{ outline:none; border-color:var(--forest); }
  .sync-actions{
    display:flex;
    gap:8px;
    margin-top:10px;
    flex-wrap:wrap;
  }
  .sync-status{
    font-size:11.5px;
    color:var(--ink-soft);
    margin-top:8px;
  }
  .sync-status.ok{ color:var(--stamp-green); }
  .sync-status.erro{ color:var(--stamp-red); }
</style>
</head>
<body>

<div class="wrap">

  <header>
    <p class="eyebrow">Livro-Caixa Pessoal</p>
    <h1>Meu Livro-Caixa</h1>
    <p class="sub">Controle simples de contas e lançamentos, direto no navegador. Toque em qualquer valor para editar.</p>
  </header>

  <div class="summary">
    <div class="sum-card">
      <div class="lbl">Saldo total</div>
      <div class="val" id="saldo-total">R$ 0,00</div>
    </div>
    <div class="sum-card negativo">
      <div class="lbl">Gasto pendente</div>
      <div class="val" id="gasto-pendente">R$ 0,00</div>
    </div>
    <div class="sum-card">
      <div class="lbl">Gasto total (pago + pendente)</div>
      <div class="val" id="gasto-total">R$ 0,00</div>
    </div>
  </div>

  <section class="contas">
    <p class="section-title">Contas</p>
    <div class="contas-grid" id="contas-grid"></div>
  </section>

  <section class="lancamentos">
    <p class="section-title">Lançamentos</p>
    <div class="toolbar">
      <select class="filtro" id="filtro-conta">
        <option value="todas">Todas as contas</option>
      </select>
      <select class="filtro" id="filtro-status">
        <option value="todos">Todos os status</option>
        <option value="pago">Pago</option>
        <option value="pendente">Pendente</option>
      </select>
    </div>

    <div class="ledger">
      <div class="l-head">
        <span>Descrição</span>
        <span>Conta</span>
        <span style="text-align:right">Valor</span>
        <span>Status</span>
        <span></span>
      </div>
      <div id="lancamentos-list"></div>
      <div class="empty" id="empty-msg" style="display:none">Nenhum lançamento encontrado.</div>
    </div>

    <div class="add-row">
      <button class="btn-add" id="btn-novo">+ Novo lançamento</button>
    </div>
  </section>

  <div class="sync-card">
    <div class="lbl">Sincronizar com Google Sheets</div>
    <div class="sync-row">
      <input type="text" id="sync-url" placeholder="Cole aqui a URL do Apps Script (termina em /exec)">
      <button class="btn-ghost" id="btn-sync-save">Salvar link</button>
    </div>
    <div class="sync-actions">
      <button class="btn-ghost" id="btn-sync-push">Enviar deste site → planilha</button>
      <button class="btn-ghost" id="btn-sync-pull">Trazer da planilha → este site</button>
    </div>
    <div class="sync-status" id="sync-status"></div>
  </div>

  <footer>
    <button class="btn-ghost" id="btn-export">Exportar backup (.json)</button>
    <button class="btn-ghost" id="btn-import">Importar backup</button>
    <button class="btn-ghost" id="btn-reset">Restaurar dados de exemplo</button>
    <input type="file" id="file-input" accept="application/json">
  </footer>
  <p class="note">Os dados ficam salvos no armazenamento local do seu navegador (localStorage), neste computador e neste navegador específico. Use "Exportar backup" de vez em quando para não perder nada. A sincronização com Google Sheets acima é manual: "Enviar" sobrescreve a planilha com os dados daqui, "Trazer" sobrescreve os dados daqui com os da planilha — não há mesclagem automática, então evite editar os dois lados ao mesmo tempo.</p>

</div>

<script>
(function(){
  "use strict";

  var STORAGE_KEY = "livro-caixa-v1";

  var defaultData = {
    contas: [
      { id: "dinheiro", nome: "Dinheiro", saldoInicial: 350 },
      { id: "inter",    nome: "Inter",    saldoInicial: 677 },
      { id: "itau",     nome: "Itaú",     saldoInicial: 0 }
    ],
    lancamentos: [
      { id: cryptoId(), nome: "Internet",          valor: 100, contaId: "inter",    status: "pago" },
      { id: cryptoId(), nome: "Academia",           valor: 140, contaId: "inter",    status: "pago" },
      { id: cryptoId(), nome: "Transporte",         valor: 100, contaId: "inter",    status: "pendente" },
      { id: cryptoId(), nome: "Terapia",             valor: 100, contaId: "dinheiro", status: "pago" },
      { id: cryptoId(), nome: "Plano",               valor: 20,  contaId: "inter",    status: "pago" },
      { id: cryptoId(), nome: "Deezer",              valor: 20,  contaId: "inter",    status: "pago" },
      { id: cryptoId(), nome: "Cartão Itaú",         valor: 300, contaId: "dinheiro", status: "pendente" },
      { id: cryptoId(), nome: "iCloud",              valor: 19,  contaId: "inter",    status: "pago" },
      { id: cryptoId(), nome: "Fone",                valor: 129, contaId: "inter",    status: "pago" },
      { id: cryptoId(), nome: "Creatina",            valor: 28,  contaId: "inter",    status: "pendente" },
      { id: cryptoId(), nome: "Pré-treino",          valor: 39,  contaId: "inter",    status: "pendente" },
      { id: cryptoId(), nome: "Cabelo",              valor: 28,  contaId: "inter",    status: "pago" },
      { id: cryptoId(), nome: "Pudim",               valor: 14,  contaId: "inter",    status: "pago" },
      { id: cryptoId(), nome: "Doce",                valor: 15,  contaId: "itau",     status: "pago" },
      { id: cryptoId(), nome: "Garrafa + capinha",   valor: 40,  contaId: "inter",    status: "pago" }
    ]
  };

  function cryptoId(){
    return "id-" + Math.random().toString(36).slice(2, 10) + Date.now().toString(36);
  }

  function loadData(){
    try{
      var raw = localStorage.getItem(STORAGE_KEY);
      if(raw){
        var parsed = JSON.parse(raw);
        if(parsed && parsed.contas && parsed.lancamentos) return parsed;
      }
    }catch(e){ /* ignora e usa default */ }
    return JSON.parse(JSON.stringify(defaultData));
  }

  function saveData(){
    try{
      localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
    }catch(e){
      console.warn("Não foi possível salvar no localStorage:", e);
    }
  }

  var data = loadData();

  function fmtMoney(n){
    n = Number(n) || 0;
    return n.toLocaleString('pt-BR', { style:'currency', currency:'BRL' });
  }

  function contaById(id){
    for(var i=0;i<data.contas.length;i++) if(data.contas[i].id === id) return data.contas[i];
    return null;
  }

  function saldoAtual(contaId){
    var conta = contaById(contaId);
    if(!conta) return 0;
    var gastoPago = 0;
    data.lancamentos.forEach(function(l){
      if(l.contaId === contaId && l.status === 'pago') gastoPago += Number(l.valor)||0;
    });
    return conta.saldoInicial - gastoPago;
  }

  function render(){
    // filtros de conta
    var filtroConta = document.getElementById('filtro-conta');
    var valorAtualFiltro = filtroConta.value || 'todas';
    filtroConta.innerHTML = '<option value="todas">Todas as contas</option>' +
      data.contas.map(function(c){ return '<option value="'+c.id+'">'+c.nome+'</option>'; }).join('');
    filtroConta.value = valorAtualFiltro;

    // cards de contas
    var grid = document.getElementById('contas-grid');
    grid.innerHTML = '';
    var saldoTotalGeral = 0;
    data.contas.forEach(function(conta){
      var atual = saldoAtual(conta.id);
      saldoTotalGeral += atual;
      var card = document.createElement('div');
      card.className = 'conta-card';
      card.innerHTML =
        '<div class="nome">'+escapeHtml(conta.nome)+'</div>' +
        '<div class="saldo-atual" style="color:'+(atual < 0 ? 'var(--stamp-red)' : 'var(--forest-deep)')+'">'+fmtMoney(atual)+'</div>' +
        '<div class="row"><span>Saldo inicial</span><input class="saldo-inicial-input" data-conta="'+conta.id+'" type="number" step="0.01" value="'+conta.saldoInicial+'"></div>';
      grid.appendChild(card);
    });

    document.getElementById('saldo-total').textContent = fmtMoney(saldoTotalGeral);

    var gastoTotal = 0, gastoPendente = 0;
    data.lancamentos.forEach(function(l){
      gastoTotal += Number(l.valor)||0;
      if(l.status === 'pendente') gastoPendente += Number(l.valor)||0;
    });
    document.getElementById('gasto-total').textContent = fmtMoney(gastoTotal);
    document.getElementById('gasto-pendente').textContent = fmtMoney(gastoPendente);

    // lista de lançamentos
    var fConta = document.getElementById('filtro-conta').value;
    var fStatus = document.getElementById('filtro-status').value;
    var list = document.getElementById('lancamentos-list');
    list.innerHTML = '';

    var visiveis = data.lancamentos.filter(function(l){
      if(fConta !== 'todas' && l.contaId !== fConta) return false;
      if(fStatus !== 'todos' && l.status !== fStatus) return false;
      return true;
    });

    document.getElementById('empty-msg').style.display = visiveis.length ? 'none' : 'block';

    visiveis.forEach(function(l){
      var row = document.createElement('div');
      row.className = 'l-row';
      row.dataset.id = l.id;

      var contaOptions = data.contas.map(function(c){
        return '<option value="'+c.id+'"'+(c.id===l.contaId?' selected':'')+'>'+escapeHtml(c.nome)+'</option>';
      }).join('');

      row.innerHTML =
        '<div class="c-nome"><input type="text" value="'+escapeAttr(l.nome)+'" data-field="nome"></div>' +
        '<div class="c-conta"><select class="c-conta-select" data-field="contaId">'+contaOptions+'</select></div>' +
        '<div class="c-valor"><input class="c-valor-input" type="number" step="0.01" value="'+l.valor+'" data-field="valor"></div>' +
        '<div class="c-status"><span class="stamp '+l.status+'" data-field="status">'+(l.status==='pago'?'Pago':'Pendente')+'</span></div>' +
        '<div class="c-del"><button class="btn-del" title="Excluir">✕</button></div>';

      list.appendChild(row);
    });
  }

  function escapeHtml(s){
    return String(s).replace(/[&<>"']/g, function(c){
      return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c];
    });
  }
  function escapeAttr(s){ return escapeHtml(s); }

  // ---------- eventos ----------

  document.getElementById('contas-grid').addEventListener('change', function(e){
    var t = e.target;
    if(t.classList.contains('saldo-inicial-input')){
      var conta = contaById(t.dataset.conta);
      if(conta){
        conta.saldoInicial = parseFloat(t.value) || 0;
        saveData();
        render();
      }
    }
  });

  document.getElementById('lancamentos-list').addEventListener('change', function(e){
    var row = e.target.closest('.l-row');
    if(!row) return;
    var l = data.lancamentos.find(function(x){ return x.id === row.dataset.id; });
    if(!l) return;
    var field = e.target.dataset.field;
    if(field === 'nome') l.nome = e.target.value;
    if(field === 'contaId') l.contaId = e.target.value;
    if(field === 'valor') l.valor = parseFloat(e.target.value) || 0;
    saveData();
    render();
  });

  document.getElementById('lancamentos-list').addEventListener('click', function(e){
    var row = e.target.closest('.l-row');
    if(!row) return;
    var l = data.lancamentos.find(function(x){ return x.id === row.dataset.id; });
    if(!l) return;

    if(e.target.classList.contains('stamp')){
      l.status = (l.status === 'pago') ? 'pendente' : 'pago';
      saveData();
      render();
    }
    if(e.target.classList.contains('btn-del')){
      if(confirm('Excluir "'+l.nome+'"?')){
        data.lancamentos = data.lancamentos.filter(function(x){ return x.id !== l.id; });
        saveData();
        render();
      }
    }
  });

  document.getElementById('filtro-conta').addEventListener('change', render);
  document.getElementById('filtro-status').addEventListener('change', render);

  document.getElementById('btn-novo').addEventListener('click', function(){
    data.lancamentos.unshift({
      id: cryptoId(),
      nome: 'Novo lançamento',
      valor: 0,
      contaId: data.contas[0] ? data.contas[0].id : '',
      status: 'pendente'
    });
    saveData();
    render();
    var first = document.querySelector('.l-row .c-nome input');
    if(first){ first.focus(); first.select(); }
  });

  document.getElementById('btn-export').addEventListener('click', function(){
    var blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
    var url = URL.createObjectURL(blob);
    var a = document.createElement('a');
    var hoje = new Date().toISOString().slice(0,10);
    a.href = url;
    a.download = 'livro-caixa-backup-' + hoje + '.json';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
  });

  document.getElementById('btn-import').addEventListener('click', function(){
    document.getElementById('file-input').click();
  });

  document.getElementById('file-input').addEventListener('change', function(e){
    var file = e.target.files[0];
    if(!file) return;
    var reader = new FileReader();
    reader.onload = function(ev){
      try{
        var parsed = JSON.parse(ev.target.result);
        if(parsed && parsed.contas && parsed.lancamentos){
          data = parsed;
          saveData();
          render();
        } else {
          alert('Arquivo inválido: formato não reconhecido.');
        }
      }catch(err){
        alert('Não foi possível ler o arquivo: ' + err.message);
      }
    };
    reader.readAsText(file);
    e.target.value = '';
  });

  document.getElementById('btn-reset').addEventListener('click', function(){
    if(confirm('Isso vai substituir todos os dados atuais pelos dados de exemplo originais. Continuar?')){
      data = JSON.parse(JSON.stringify(defaultData));
      saveData();
      render();
    }
  });

  // ---------- sincronização com Google Sheets ----------

  var SYNC_URL_KEY = "livro-caixa-sync-url";

  function getSyncUrl(){
    return localStorage.getItem(SYNC_URL_KEY) || "";
  }

  function setSyncStatus(msg, tipo){
    var el = document.getElementById('sync-status');
    el.textContent = msg;
    el.className = 'sync-status' + (tipo ? ' ' + tipo : '');
  }

  document.getElementById('sync-url').value = getSyncUrl();

  document.getElementById('btn-sync-save').addEventListener('click', function(){
    var url = document.getElementById('sync-url').value.trim();
    localStorage.setItem(SYNC_URL_KEY, url);
    setSyncStatus(url ? 'Link salvo.' : 'Link removido.', 'ok');
  });

  document.getElementById('btn-sync-push').addEventListener('click', function(){
    var url = getSyncUrl();
    if(!url){ setSyncStatus('Cole e salve o link do Apps Script primeiro.', 'erro'); return; }
    setSyncStatus('Enviando...', '');
    fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'text/plain;charset=utf-8' },
      body: JSON.stringify(data)
    })
    .then(function(r){ if(!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
    .then(function(){ setSyncStatus('Enviado para a planilha com sucesso.', 'ok'); })
    .catch(function(err){ setSyncStatus('Erro ao enviar: ' + err.message, 'erro'); });
  });

  document.getElementById('btn-sync-pull').addEventListener('click', function(){
    var url = getSyncUrl();
    if(!url){ setSyncStatus('Cole e salve o link do Apps Script primeiro.', 'erro'); return; }
    if(!confirm('Isso vai substituir os dados deste site pelos dados da planilha. Continuar?')) return;
    setSyncStatus('Buscando...', '');
    fetch(url)
      .then(function(r){ if(!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
      .then(function(json){
        if(!json.contas || !json.lancamentos) throw new Error('resposta em formato inesperado');
        data = json;
        saveData();
        render();
        setSyncStatus('Dados trazidos da planilha com sucesso.', 'ok');
      })
      .catch(function(err){ setSyncStatus('Erro ao buscar: ' + err.message, 'erro'); });
  });

  render();
})();
</script>

</body>
</html>
