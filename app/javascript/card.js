const payjp = () => {
  const submit = document.getElementById('button');
  submit.addEventListener('click', (e) => {
    e.preventDefault();
    
    const form = document.getElementById("charge-form");
    const formData = new FormData(form)
  // カードオブジェクトの生成
    const card = {
      number: formData.get("solditem_address[number]"),
      cvc: formData.get("solditem_address[cvc]"),
      exp_month: formData.get("solditem_address[exp_month]"),
      exp_year: `20${formData.get("solditem_address[exp_year]")}`
    };
  // PAYJP公開キーのセット
    Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  // トークンの生成
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const token_html = `<input value=${token} name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", token_html);
      // カードデータをサーバーに送らないように消す(トークンがあれば大丈夫)
        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");
      // 送信
        form.submit();
      }else{
    // 入力ミスがあったときはそのままcreateアクションに送信
        form.submit();
      };
    });
  }); 
};

window.addEventListener('load', payjp);