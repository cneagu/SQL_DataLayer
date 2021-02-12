using System;

namespace DataLayer_Test
{
    public class MessageInbox
    {
        #region Properties
        public Guid MessageID { get; set; }
        public Guid UserID { get; set; }
        public Guid AnnoucementID { get; set; }
        public DateTime CreationDate { get; set; }
        public bool Read { get; set; }
        public string MesageContent { get; set; }
        #endregion
    }
}
