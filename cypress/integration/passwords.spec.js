/// <reference types="Cypress" />

describe('user password', () => {

  // target holds a parsed url for the tested host
  let target;

  beforeEach(() => {
    cy.target().then(($tgt) => {
      target = $tgt
    })
  })

  context('as an authenticated user', () => {
    beforeEach(() => {
      cy.login()
      cy.visit(`${target.href}reset.php`)
    })
  
    it('I can change my password', () => {
      //pending
    })
  })

  context('as an unauthenticated user', () => {
    context('who has forgotten my username', () => {
      it('I can request a username lookup', () => {
        //pending
      })
      it('I can receive an email reminder containing my username', () => {
        //pending
      })
    })

    context('who has forgotten my password', () => {
      it('I can request a password reset token', () => {
        //pending
      })
      it('I can receive a password reset token email', () => {
        //pending
      })
      it('I can reset my password', () => {
        //pending
      })
    })
  })
})
