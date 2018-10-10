/// <reference types="Cypress" />

describe('user profile', () => {
  let target;

  beforeEach(() => {
    cy.login('dev')
    cy.target('profiles').then((tgt) => {
      target = tgt
      cy.visit(`${target.href}profile.php`)
    })
  })

  context('as a logged in user', () => {
    it('I can see my personal profile data', () => {
      cy.get('fieldset > legend').contains('Main Profile:')
    })
  })

  context('as a new user', () => {
    it('I can enter my profile data', () => {
      //pending
    })
  })

  context('as an existing user', () => {
    it('I can change my profile data', () => {
      //pending
    })
  })
})
