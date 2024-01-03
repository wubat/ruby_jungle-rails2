describe("Product Details", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("displays product details when click on product link", () => {
    cy.get(".products article:first-child a").click();
    cy.get(".product-detail").should("be.visible");
  });
});