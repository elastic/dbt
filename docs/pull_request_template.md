<!---
Provide a short summary in the Title above. Examples of good PR titles:
* "Feature: add so-and-so models"
* "Fix: deduplicate such-and-such"
* "Update: dbt version 0.13.0"
-->

## Description & motivation
<!---
Describe your changes, and why you're making them. Is this linked to an open
issue, a Trello card, or another pull request? Link it here.
-->


## Changes to existing models:
<!---
Include this section if you are changing any existing models. Link any related
pull requests on your BI tool, or instructions for merge (e.g. whether old
models should be dropped after merge, or whether a full-refresh run is required)
-->

## Checklist:
<!---
This checklist is mostly useful as a reminder of small things that can easily be
forgotten – it is meant as a helpful tool rather than hoops to jump through.
Put an `x` in all the items that apply, make notes next to any that haven't been
addressed, and remove any items that are not relevant to this PR.
-->
- [ ] My pull request represents one logical piece of work.
- [ ] My commits are related to the pull request and look clean.
- [ ] My SQL follows the [Fishtown Analytics style guide](https://github.com/fishtown-analytics/corp/blob/master/dbt_coding_conventions.md).
- [ ] I have materialized my models appropriately.
- [ ] I have added appropriate tests and documentation to any new models.
- [ ] I have updated the README file.
{%- if project.warehouse == 'redshift' %}
- [ ] I have added sort and dist keys to models materialized as tables.
- [ ] I have validated the SQL in any late-binding views.
{% endif %}

## Reviewer Checklist
![](https://lh3.googleusercontent.com/APRaqj2PsgF4mC5FIKQX8zyE18lqHv5hbmurQ5At_JYv8pl0gqwTaJECeNUtYrGL3bV0FqCLq2YbdAdKGIGZU-Cdew7SNhCELY4K9p8uMTK4guhxwZ6Lu-4lq_VRy_uf1YpH1GIA)

- [ ] All checks have passed.