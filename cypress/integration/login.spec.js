/// <reference types="Cypress" />

const P_PROTOCOL = 'https:'
const P_HOST = 'localhost'
const P_PORT = '3300'
const PORTAL_URL = `${P_PROTOCOL}//${P_HOST}:${P_PORT}`

const VALID_USERNAME='developer'
const VALID_EMAIL='burnerdev@burningflipside.com'
const VALID_PASSWORD='p@s5w0rd'

context('Location', () => {
  beforeEach(() => {
    cy.visit(PORTAL_URL)
  })

  it('cy.location() - get window.location', () => {
    cy.location().should((location) => {
      expect(location.href).to.eq(`${PORTAL_URL}/`)
      expect(location.hostname).to.eq(P_HOST)
      expect(location.origin).to.eq(`${PORTAL_URL}`)
      expect(location.pathname).to.eq('/')
      expect(location.port).to.eq(`${P_PORT}`)
      expect(location.protocol).to.eq(`${P_PROTOCOL}`)
    })
  })

  it('cy.url() - get the current URL', () => {
    cy.url().should('eq', `${PORTAL_URL}/`)
  })
})

context('using login url', () => {
  beforeEach(() => {
    cy.visit(`${PORTAL_URL}/login.php`)
  })

  it('says Burning Flipside Profile Login', () => {
    cy.get('body').contains('Burning Flipside Profile Login')
  })

  it('when submitting empty form', () => {
    cy.get('#login_main_form').children('button[type=submit]').click()
    // there is no visible error
  })
})

context('using login modal', () => {
  beforeEach(() => {
    cy.visit(`${PORTAL_URL}/logout.php`)
    cy.visit(`${PORTAL_URL}`)

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
      // there is no visible error      
    })
  })

  it('when submitting incomplete credentials', () => {    
    cy.get('a').contains('Login').click()
    cy.get('#login_dialog_form').children('input[name=username]').type(VALID_USERNAME)
    cy.get('#login_dialog_form').children('button[type=submit]').click()
    cy.wait('@authenticate').then(function(xhr){
      expect(xhr.status).to.eq(403)
      // there is no visible error      
    })
  })

  it('when submitting invalid credentials', () => {    
    cy.get('a').contains('Login').click()
    cy.get('#login_dialog_form').children('input[name=username]').type(VALID_USERNAME)
    cy.get('#login_dialog_form').children('input[name=password]').type('notmyrealpassword')
    cy.get('#login_dialog_form').children('button[type=submit]').click()
    cy.wait('@authenticate').then(function(xhr){
      expect(xhr.status).to.eq(403)
      // there is no visible error      
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
