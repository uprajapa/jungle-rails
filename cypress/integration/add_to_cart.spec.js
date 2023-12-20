describe('Add to cart', () => {

  it('should add product to cart on click', () => {
    cy.visit('http://localhost:3000/')

    cy.get('.btn:not(.disabled)').first().should('be.visible').click();

    cy.get('.nav-link').should('contain', '1');
  })
})