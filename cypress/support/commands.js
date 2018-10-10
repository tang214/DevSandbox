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

Cypress.Commands.add('target', (service) => {
  let hostUrl;

  // implement a more portable configuration to facilitate
  // running against a different installation
  switch(service) {
    case 'profiles':
      hostUrl = 'https://localhost:3300';
      break;
    case 'secure':
      hostUrl = 'https://localhost:3400';
      break;
  }
  return url.parse(hostUrl);
})

Cypress.Commands.add('user', (role) => {
  let user;

  // implement a more portable configuration to facilitate
  // running against a different installation
  // define more user roles as neseccary
  switch(role) {
    case 'dev':
      user = {
        email: 'burnerdev@burningflipside.com',
        username: 'developer',
        password: 'p@s5w0rd'
      };
      break;
    case 'admin':
      user = {};
      break;
  }
  return user;
})

// perform login by posting directly to API
Cypress.Commands.add('login', (role) => {
  cy.target('profiles').then((tgt) => {
    const target = tgt

    cy.user(role).then((usr) => {
      const user = usr

      cy.request({
        method: 'POST',
        url: `${target.href}api/v1/login`,
        body: {
          username: user.username,
          password: user.password
        }
      })
      .then((resp) => {
        // log statements are useless within the context of tests
        // investigate implementing debugger for the ability to
        // inspect within testing contexts
        console.log(resp)
      })
    })
  })
})
