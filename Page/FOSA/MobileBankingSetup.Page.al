page 50108 "Mobile Banking Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Mobile Banking Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Mobile Banking Appl. Nos."; Rec."Mobile Banking Appl. Nos.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Banking Activation Nos."; Rec."Mobile Banking Activation Nos.")
                {
                    ApplicationArea = All;
                }
                field("Paybill Bank"; Rec."Paybill Bank")
                {
                    ApplicationArea = All;
                }
                field("Loan Repay SMS Template"; Rec."Loan Repay SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }

                field("Deposit SMS Template"; Rec."Deposit SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Mobile Banking Template Name"; Rec."Mobile Banking Template Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile Banking Batch Name"; Rec."Mobile Banking Batch Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            /* action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            } */
        }
    }

    var
        myInt: Integer;
}