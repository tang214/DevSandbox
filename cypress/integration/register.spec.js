/// <reference types="Cypress" />

describe('user profile', () => {
  let target;

  beforeEach(() => {
    cy.target('profiles').then((tgt) => {
      target = tgt
    })
  })

  context('as an anonymous user', () => {
    beforeEach(() => {
      cy.visit(`${target.href}register.php`)
    })

    it('I see the registration form', () => {
      cy.get('fieldset > legend').contains('Burning Flipside Profile Registration')
    })

    it('I can register a new account', () => {
      //pending
    })

    it('I can receive a confirmation email', () => {
      //pending
    })

    it('I can confirm a new account', () => {
      //pending
    })
  })
})
