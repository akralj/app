#import Home from './pages/home.vue'
import PanelLeft from './pages/panel-left.vue'
import MasterDetailMaster from './pages/master.vue'
import MasterDetailDetail from './pages/detail.vue'
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
    component: MasterDetailMaster
    master: true
    detailRoutes: [
      {
        path: '/master-detail/:id/'
        component: MasterDetailDetail
      }
    ]
  }
  # Default route (404 page). MUST BE THE LAST
  {
    path: '(.*)'
    component: NotFound
  }
])
