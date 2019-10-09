#import Home from './pages/home.vue'
import PanelLeft from './pages/panel-left.vue'
import MasterView from './pages/master.vue'
import DetailView from './pages/detail.vue'
import NotFound from './pages/404.vue'

# Pages
export default([
  # Index page
  # { path: '/', component: Home },
  # Left Panel
  {
    path: '/panel-left/'
    component: PanelLeft
  }
  # Components
  {
    path: '/'
    component: MasterView
    master: true
    detailRoutes: [
      {
        #path: '/master-detail/:id/'
        path: '/:id/'
        component: DetailView
      }
    ]
  }
  # Default route (404 page). MUST BE THE LAST
  {
    path: '(.*)'
    component: NotFound
  }
])
