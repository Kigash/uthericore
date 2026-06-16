page 50117 "Treasury Return Bank-Posted"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Treasury Return Bank Header";
    SourceTableView = where(Status = filter(Approved), Posted = filter(true));
    Editable = false;
    CardPageId = 50111;

    layout
    {
        area(Content)
        {
            repeater(TreasuryRetunBank)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;

                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = All;

                }
                field("Bank Account Balance"; Rec."Bank Account Balance")
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;

                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}