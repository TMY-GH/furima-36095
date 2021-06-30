const price_calc = () => {
  const price_input = document.getElementById('item-price');
  price_input.addEventListener('keyup', (e) => {
    const price = price_input.value;
    // 販売手数料表示
    const tax = Math.round(price * 0.1);
    const html_tax =`${tax}`;
    const tax_place = document.getElementById('add-tax-price');
    tax_place.innerHTML = "";
    tax_place.insertAdjacentHTML('afterbegin', html_tax);
    // 販売利益表示
    const profit = price - tax;
    const html_profit =`${profit}`;
    const profit_place = document.getElementById('profit');
    profit_place.innerHTML = "";
    profit_place.insertAdjacentHTML('afterbegin', html_profit);
  });
};

window.addEventListener('load', price_calc);
