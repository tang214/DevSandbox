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
      cy.login()
      cy.visit(`${target.href}profile.php`)
    })
  
    it('I can see my personal profile data', () => {
      cy.get('fieldset > legend').contains('Main Profile:')
    })
  })
  
})
