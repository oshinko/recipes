import marked from 'marked'

window.onload = () => {
  if (typeof RECIPES !== 'undefined') {
    RECIPES.forEach(recipe => {
      let el = document.querySelector(recipe.el)
      if (el) el.innerHTML = marked(recipe.text, { breaks: true })
    });
  }
}
