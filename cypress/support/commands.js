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

/**
 * cy.target provides a single point of reference to the target host details
 * @param target the project subdomain being tested
 * @returns {obj}
 * returns an empty object if target is not defined
 * Url {
 *   protocol: 'https:',
 *   slashes: true,
 *   auth: null,
 *   host: 'localhost:3000',
 *   port: '3000',
 *   hostname: 'localhost',
 *   hash: null,
 *   search: null,
 *   query: null,
 *   pathname: '/',
 *   path: '/',
 *   href: 'https://localhost:3000/'
 * }
 *
 */
Cypress.Commands.add('target', (service) => {
  let hostUrl = {};

  switch(service) {
    case 'profiles':
      hostUrl = Cypress.env('profilesUrl');
      break;
    case 'secure':
      hostUrl = Cypress.env('secureUrl');
      break;
  }
  return url.parse(hostUrl);
})

/**
 * cy.user provides a single point of reference to user login details
 * @param role the user role for testing actions
 * @returns {obj}
 * returns an empty object if role is not defined
 * User {
 *   email: 'burnerdev@burningflipside.com',
 *   username: 'developer',
 *   password: 'p@s5w0rd'
 * }
 *
 */
Cypress.Commands.add('user', (role) => {
  let user = {};

  // investigate a more portable configuration to facilitate
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

// allow quick login for tests by posting directly to API
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
