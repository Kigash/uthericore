page 50378 "Agency Banking Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Agency Banking Setup";
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Agent Application Nos."; Rec."Agent Application Nos.")
                {
                    ApplicationArea = All;
                }
                field("Agent Nos."; Rec."Agent Nos.")
                {
                    ApplicationArea = All;
                }
                field("Maximum Withdrawal Per day"; Rec."Maximum Withdrawal Per day")
                {
                    ApplicationArea = All;

                }
                field("Internal Agent A/C Type"; Rec."Internal Agent A/C Type")
                {
                    ApplicationArea = All;
                }
                field("Internal Agent Income A/c"; Rec."Internal Agent Income A/C")
                {
                    ApplicationArea = All;

                }
                field("Agency Banking(Non Mobile Banking)"; Rec."Agency Banking(Non Mobile Banking)")
                {
                    ApplicationArea = All;
                }

            }
            group(Posting)
            {
                field("Agency Template Name"; Rec."Agency Template Name")
                {
                    ApplicationArea = All;
                }
                field("Agency Batch Name"; Rec."Agency Batch Name")
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
            /*  action(ActionName)
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