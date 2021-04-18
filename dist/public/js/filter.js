function filter() {
  const btnFilters = document.querySelectorAll('.js-filter-btn')
  const btnCards = document.querySelectorAll('.js-filter-card')

  btnFilters.forEach(btn => {
    btn.addEventListener("click", e => {
      btnCards.forEach(card => {
        if (e.target.id == card.getAttribute("data-filter")) {
          console.log(card)
          card.style.display = "block";
        } else {
          card.style.display = "none";
        }
      });
    })
  });
}

filter();