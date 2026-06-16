page 50110 "Treasury Transactions-Posted"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Treasury Transaction Header";
    SourceTableView = WHERE(Status = FILTER(Approved), Posted = filter(true));
    CardPageId = 50080;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Treasury)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;

                }
                field("Created By"; Rec."Created By")
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