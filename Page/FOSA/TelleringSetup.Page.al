page 50106 "Tellering Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tellering Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Teller Transaction Nos."; Rec."Teller Transaction Nos.")
                {
                    ApplicationArea = All;
                }
                field("Teller Return Treasury Nos."; Rec."Teller Return Treasury Nos.")
                {
                    ApplicationArea = All;
                }
                field("Teller Close Till Nos."; Rec."Teller Close Till Nos.")
                {
                    ApplicationArea = All;
                }

                field("Inter Teller Transfer Nos"; Rec."Inter Teller Transfer Nos")
                {
                    ApplicationArea = All;
                }

            }

            group(Notification)
            {
                field("Notify Member"; Rec."Notify Member")
                {
                    ApplicationArea = All;
                }
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }
                field("SMS Template (deposit)"; Rec."SMS Template (deposit)")
                {
                    ApplicationArea = All;
                    multiline = true;
                }
                field("Email Template (deposit)"; Rec."Email Template (deposit)")
                {
                    ApplicationArea = All;
                    multiline = true;
                }

                field("SMS Template (reversal)"; Rec."SMS Template (reversal)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Template (reversal)"; Rec."Email Template (reversal)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (withdrawal)"; Rec."SMS Template (withdrawal)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Template (withdrawal)"; Rec."Email Template (withdrawal)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group(Posting)
            {
                field("Teller Template Name"; Rec."Teller Template Name")
                {
                    ApplicationArea = All;
                }
                field("Teller Batch Name"; Rec."Teller Batch Name")
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
            /*   action(ActionName)
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