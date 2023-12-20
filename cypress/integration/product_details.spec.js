describe('Product details', () => {

  it('navigates to product detail page when product is clicked on home page', () => {
    cy.visit('http://localhost:3000/')

    cy.get('article a').first().click();

    cy.url().should('include', '/products/');
  })
})