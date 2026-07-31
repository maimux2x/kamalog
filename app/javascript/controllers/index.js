// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import Sortable from '@stimulus-components/sortable'

eagerLoadControllersFrom("controllers", application)

application.register('sortable', Sortable)
