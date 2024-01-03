describe("Add To Cart", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("cart number changes when add to cart button is pressed", () => {
    cy.get(".products article:first-child button").click();
    cy.get(".cart-button").contains("1");
  });
});