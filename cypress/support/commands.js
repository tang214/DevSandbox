// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })
const url = require('url');

// this will need to be exapnded to accomodate multiple targets
// perhaps this command can accept a parameter to return the desired url?
Cypress.Commands.add('target', () => {
  // this should probably be set in ENV
  return url.parse('https://localhost:3300');
})

Cypress.Commands.add('user', () => {
  // this should probably be set in ENV
  return {
    email: 'burnerdev@burningflipside.com',
    username: 'developer',
    password: 'p@s5w0rd'
  };
})

// perform login by posting directly to API
Cypress.Commands.add('login', () => {
  cy.target().then(($o) => {
    const target = $o

    cy.user().then(($o) => {
      const user = $o

      cy.request({
        method: 'POST',
        url: `${target.href}api/v1/login`,
        body: {
          username: user.username,
          password: user.password
        }
      })
      .then((resp) => {
        console.log(resp)
      })
    })
  })
})
