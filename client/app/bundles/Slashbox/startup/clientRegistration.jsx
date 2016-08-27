import ReactOnRails from 'react-on-rails';
import DataClipApp from './DataClipAppClient';
import SideBar from './SideBarClient';

// This is how react_on_rails can see the HelloWorldApp in the browser.
ReactOnRails.register({ DataClipApp, SideBar });
