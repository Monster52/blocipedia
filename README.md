[![Code Climate](https://codeclimate.com/github/Monster52/blocipedia/badges/gpa.svg)](https://codeclimate.com/github/Monster52/blocipedia)
[![Test Coverage](https://codeclimate.com/github/Monster52/blocipedia/badges/coverage.svg)](https://codeclimate.com/github/Monster52/blocipedia/coverage)
[![Issue Count](https://codeclimate.com/github/Monster52/blocipedia/badges/issue_count.svg)](https://codeclimate.com/github/Monster52/blocipedia)

## Blocipedia: a Wiki style app where users can create public or private wikis.

Made with my mentor at [Bloc](http://bloc.io).

## Things I learned on this project.
- Allow Users to Sign in using Devise gem
- Create User Roles
- Authorize Users using Pundit gem
- A Markdown editor using Redcarpet which also does syntax highlighting
- Payments for Premium Users through Stripe
- Hide API keys using Figaro
- Make the URLS nicer with Friendly_id

## Things to fix
As of right now the Standard user can not access private wikis they are a collaborator on.
I want to use EpicEditor for the Markdown which allows live preview from Markdown to HTML.
I also want to re-style the pages to something more modern and not so bootstrapish.
