devtools::check_rhub(email="Matthieu.Stigler@gmail.com", interactive=FALSE)

devtools::check_win_devel()
devtools::check_win_release()
devtools::check_win_oldrelease()

## then
# direct: devtools::submit_cran()