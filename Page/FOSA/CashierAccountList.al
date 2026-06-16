page 50159 "Cashier Account List"
{
    ApplicationArea = All;
    Caption = 'Cashier Account List';
    CardPageId = "Cashier Account Card";
    PageType = List;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type" = filter("Till Account"));
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
                field("Cashier Balance"; Rec."Cashier Balance")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
