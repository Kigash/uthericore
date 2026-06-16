page 50390 "Guarantor Substitution Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Guarantor Substitution Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Guarantor Substitution Nos."; Rec."Guarantor Substitution Nos.")
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
                    MultiLine = true;
                }
                field("Email Template (Pending Appr.)"; Rec."Email Template (Pending Appr.)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (Pending Appr.)"; Rec."SMS Template (Pending Appr.)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Template (Approved)"; Rec."Email Template (Approved)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (Approved)"; Rec."SMS Template (Approved)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Template (Rejected)"; Rec."Email Template (Rejected)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (Rejected)"; Rec."SMS Template (Rejected)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Notify Guarantor"; Rec."Notify Guarantor")
                {
                    ApplicationArea = All;
                }
                field("Email Template (Guarantor)-New"; Rec."Email Template (Guarantor)-New")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (Guarantor)-New"; Rec."SMS Template (Guarantor)-New")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Template (Guarantor)-Approved"; Rec."Email Template (Guarantor)-Approved")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (Guarantor)-Approved"; Rec."SMS Template (Guarantor)-Approved")
                {
                    ApplicationArea = All;
                    MultiLine = true;
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