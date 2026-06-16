page 50065 "Teller Transactions-Rejected"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Teller Transaction Header";
    SourceTableView = WHERE(Status = FILTER(Rejected), Posted = filter(false));
    CardPageId = 50060;
    layout
    {
        area(Content)
        {
            repeater(Teller)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;

                }
                field("Teller User ID"; Rec."Teller User ID")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = All;

                }
                field("Transaction Amount"; Rec."Transaction Amount")
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
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