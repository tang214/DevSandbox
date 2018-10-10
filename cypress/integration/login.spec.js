// / <reference types="Cypress" />

describe('user login', () => {
  let target;
  let user;

  beforeEach(() => {
    // get target from support/commands
    cy.target('profiles').then((tgt) => {
      target = tgt;
    });
    // get user from support/commands
    cy.user('dev').then((usr) => {
      user = usr;
    });
  });

  context('Location', () => {
    beforeEach(() => {
      cy.visit(target.href);
    });

    it('cy.location() - get window.location', () => {
      cy.location().should((location) => {
        expect(location.href).to.eq(target.href);
        expect(location.hostname).to.eq(target.hostname);
        expect(location.origin).to.eq(`${target.protocol}//${target.host}`);
        expect(location.pathname).to.eq('/');
        expect(location.port).to.eq(target.port);
        expect(location.protocol).to.eq(target.protocol);
      });
    });

    it('cy.url() - get the current URL', () => {
      cy.url().should('eq', `${target.href}`);
    });
  });

  context('using login url', () => {
    beforeEach(() => {
      cy.visit(`${target.href}login.php`);
    });

    it('says Burning Flipside Profile Login', () => {
      cy.get('body').contains('Burning Flipside Profile Login');
    });

    it('when submitting empty form', () => {
      cy.get('#login_main_form').children('button[type=submit]').click();
      // there is no visible feedback that an error has occurred
    });
  });

  context('using login modal', () => {
    beforeEach(() => {
      cy.logout();
      cy.visit(`${target.href}`);

      cy.server();
      cy.route('POST', '/api/v1/login').as('authenticate');
    });

    it('says Burning Flipside Profile Login', () => {
      cy.get('a').contains('Login').click();
      cy.get('#login-dialog').contains('Login');
    });

    it('when submitting empty form', () => {
      cy.get('a').contains('Login').click();
      cy.get('#login_dialog_form').children('button[type=submit]').click();
      cy.wait('@authenticate').then((xhr) => {
        expect(xhr.status).to.eq(403);
        // I expect there should be visible feedback that an error has occurred
        // there is none
      });
    });

    it('form can be submitted by pressing the enter key', () => {
      cy.get('a').contains('Login').click();
      cy.get('#login_dialog_form').children('input[name=username]').type('me@example.com{enter}');
      cy.wait('@authenticate').then((xhr) => {
        expect(xhr.status).to.eq(403);
        // I expect there should be visible feedback that an error has occurred
        // there is none
      });
    });

    it('when submitting incomplete credentials', () => {
      cy.get('a').contains('Login').click();
      cy.get('#login_dialog_form').children('input[name=username]').type(user.username);
      cy.get('#login_dialog_form').children('button[type=submit]').click();
      cy.wait('@authenticate').then((xhr) => {
        expect(xhr.status).to.eq(403);
        // I expect there should be visible feedback that an error has occurred
        // there is none
      });
    });

    it('when submitting invalid credentials', () => {
      cy.get('a').contains('Login').click();
      cy.get('#login_dialog_form').children('input[name=username]').type(user.username);
      cy.get('#login_dialog_form').children('input[name=password]').type('notmyrealpassword');
      cy.get('#login_dialog_form').children('button[type=submit]').click();
      cy.wait('@authenticate').then((xhr) => {
        expect(xhr.status).to.eq(403);
        // I expect there should be visible feedback that an error has occurred
        // there is none
      });
    });

    it('allows login using username', () => {
      cy.get('a').contains('Login').click();
      cy.get('#login_dialog_form').children('input[name=username]').type(user.username);
      cy.get('#login_dialog_form').children('input[name=password]').type(user.password);
      cy.get('#login_dialog_form').children('button[type=submit]').click();
      cy.wait('@authenticate').then((xhr) => {
        expect(xhr.status).to.eq(200);

        cy.location().should((location) => {
          expect(location.href).to.eq(target.href);
        });
      });
    });

    it('allows login using email sddress', () => {
      cy.get('a').contains('Login').click();
      cy.get('#login_dialog_form').children('input[name=username]').type(user.email);
      cy.get('#login_dialog_form').children('input[name=password]').type(user.password);
      cy.get('#login_dialog_form').children('button[type=submit]').click();
      cy.wait('@authenticate').then((xhr) => {
        expect(xhr.status).to.eq(200);

        cy.location().should((location) => {
          expect(location.href).to.eq(target.href);
        });
      });
    });
  });
});
