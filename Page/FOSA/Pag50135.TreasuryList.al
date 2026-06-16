page 50135 "Treasury List"
{
    ApplicationArea = All;
    Caption = 'Treasury List';
    CardPageId = "Treasury Card";
    PageType = List;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type" = filter("Treasury Account"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the bank account.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the bank where you have the bank account.';
                }
                field("Treasury Balance"; Rec."Treasury Balance")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
