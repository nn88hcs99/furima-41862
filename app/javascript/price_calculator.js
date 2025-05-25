const price = () => {
  const priceInput = document.getElementById("item-price");
  const taxField = document.getElementById("add-tax-price");
  const profitField = document.getElementById("profit");
  
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const priceNum = parseInt(priceInput.value.trim(), 10);

    if (isNaN(priceNum)) return;

    const tax = Math.floor(priceNum * 0.1);
    const profit = priceNum - tax;
    
    taxField.textContent = tax.toLocaleString();
    profitField.textContent = profit.toLocaleString();
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);