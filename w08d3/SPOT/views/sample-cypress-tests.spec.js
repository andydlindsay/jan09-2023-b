// visit the homepage

describe('Basic Page Visits', () => {
  it('Visits the Homepage', () => {
    cy.visit('/');
  });
  it('Visits the Cycle', () => {
    cy.visit('/cycle');
  });
  it('Click the Front-end Sector', () => {
    cy.get('a > text > .textpath').click();
  });
});

describe('Add An Objective', () => {
  it('Visits the Day', () => {
    cy.visit('/days/38');
    cy.get('[href="/objectives/new/38"]').click();
    cy.get('#question').type('Test Objective');

  });
});
