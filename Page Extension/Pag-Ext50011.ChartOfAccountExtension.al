pageextension 50011 ChartOfAccountExtension extends "Chart of Accounts"
{
    layout
    {

    }
    actions
    {
        Modify("Trial Balance")
        {
            Visible = false;
        }
        addafter("Trial Balance")
        {
            action("Trial Balance Custom")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Trial Balance Report";
            }
            action("Statement Of Financial Position")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Statement Of Financial Position';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Custom State of Fin. Position";
            }
            action("Statement Of Comprehensive Income")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Statement Of Comprehensive Income';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Custom Stat of Compre. Income";
            }
        }
    }
}
