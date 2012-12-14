using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
//using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using Account;

namespace AgapeConnect
{
    public class DSUserPortalView
    {
        public List<DataserverPortal> GetPortals(Guid _ssocode)
        {
            DataserverPortalUsersEntities dspuEntities = new DataserverPortalUsersEntities();

            List<DataserverPortal> portallist = new List<DataserverPortal>();

            //IQueryable<DataserverUserPortal> plist = from pl in dspuEntities.DSUserPortals where pl.SsoCode == _ssocode select pl;

            //foreach (DataserverUserPortal p in plist)
            //{
            //    portallist.Add(new DataserverPortal { InstanceUri = p.PortalUri, InstanceName = p.PortalName });
            //}

            return portallist;
        }
    }
}