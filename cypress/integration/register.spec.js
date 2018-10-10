describe('user profile', () => {

  // target holds a parsed url for the tested host
  let target;

  beforeEach(() => {
    cy.target().then(($tgt) => {
      target = $tgt
    })
  })

  context('Location', () => {
    beforeEach(() => {
      cy.visit(`${target.href}register.php`)
    })
  
    it('I see the registration form', () => {
      cy.get('fieldset > legend').contains('Burning Flipside Profile Registration')
    })
  })
  
})
