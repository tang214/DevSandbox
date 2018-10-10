/// <reference types="Cypress" />

const url = require('url');
const target = url.parse('https://localhost:3300')

const VALID_USERNAME='developer'
const VALID_EMAIL='burnerdev@burningflipside.com'
const VALID_PASSWORD='p@s5w0rd'

context('Location', () => {
  beforeEach(() => {
    cy.visit(target.href)
  })

  it('cy.location() - get window.location', () => {
    cy.location().should((location) => {
      expect(location.href).to.eq(target.href)
      expect(location.hostname).to.eq(target.hostname)
      expect(location.origin).to.eq(`${target.protocol}//${target.host}`)
      expect(location.pathname).to.eq('/')
      expect(location.port).to.eq(target.port)
      expect(location.protocol).to.eq(target.protocol)
    })
  })

  it('cy.url() - get the current URL', () => {
    cy.url().should('eq', `${target.href}`)
  })
})

context('using login url', () => {
  beforeEach(() => {
    cy.visit(`${target.href}login.php`)
  })

  it('says Burning Flipside Profile Login', () => {
    cy.get('body').contains('Burning Flipside Profile Login')
  })

  it('when submitting empty form', () => {
    cy.get('#login_main_form').children('button[type=submit]').click()
      // there is no visible feedback that an error has occurred     
    })
})

context('using login modal', () => {
  beforeEach(() => {
    cy.visit(`${target.href}logout.php`)
    cy.visit(`${target.href}`)

    cy.server();
    cy.route("POST", "/api/v1/login").as("authenticate");
  })

  it('says Burning Flipside Profile Login', () => {
    cy.get('a').contains('Login').click()
    cy.get('#login-dialog').contains('Login')
  })

  it('when submitting empty form', () => {    
    cy.get('a').contains('Login').click()
    cy.get('#login_dialog_form').children('button[type=submit]').click()
    cy.wait('@authenticate').then(function(xhr){
      expect(xhr.status).to.eq(403)
      // there is no visible feedback that an error has occurred     
    })
  })

  it('when submitting incomplete credentials', () => {    
    cy.get('a').contains('Login').click()
    cy.get('#login_dialog_form').children('input[name=username]').type(VALID_USERNAME)
    cy.get('#login_dialog_form').children('button[type=submit]').click()
    cy.wait('@authenticate').then(function(xhr){
      expect(xhr.status).to.eq(403)
      // there is no visible feedback that an error has occurred     
    })
  })

  it('when submitting invalid credentials', () => {    
    cy.get('a').contains('Login').click()
    cy.get('#login_dialog_form').children('input[name=username]').type(VALID_USERNAME)
    cy.get('#login_dialog_form').children('input[name=password]').type('notmyrealpassword')
    cy.get('#login_dialog_form').children('button[type=submit]').click()
    cy.wait('@authenticate').then(function(xhr){
      expect(xhr.status).to.eq(403)
      // there is no visible feedback that an error has occurred     
    })
  })

  it('allows login using username', () => {    
    cy.get('a').contains('Login').click()
    cy.get('#login_dialog_form').children('input[name=username]').type(VALID_USERNAME)
    cy.get('#login_dialog_form').children('input[name=password]').type(VALID_PASSWORD)
    cy.get('#login_dialog_form').children('button[type=submit]').click()
    cy.wait('@authenticate').then(function(xhr){
      expect(xhr.status).to.eq(200)
    })
  })

  it('allows login using email sddress', () => {    
    cy.get('a').contains('Login').click()
    cy.get('#login_dialog_form').children('input[name=username]').type(VALID_EMAIL)
    cy.get('#login_dialog_form').children('input[name=password]').type(VALID_PASSWORD)
    cy.get('#login_dialog_form').children('button[type=submit]').click()
    cy.wait('@authenticate').then(function(xhr){
      expect(xhr.status).to.eq(200)
    })
  })

})

// https://docs.cypress.io/api/api/table-of-contents.html
