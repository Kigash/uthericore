page 51200 "Route Plan"
{
    DataCaptionFields = "Sales Person Code", "Sales Person Name";
    PageType = Card;
    SourceTable = "Route Plan";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                }
                field("Sales Person Name"; Rec."Sales Person Name")
                {
                    Editable = false;
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Budget Required"; Rec."Budget Required")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part("Route Plan Lines"; "Route Plan Lines")
            {
                SubPageLink = "Entry No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Submit Route Plan")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SubmitRoutePlan;

                trigger OnAction();
                begin
                    Rec."Created By" := USERID;
                    IF CONFIRM('Are you sure you want to Submit your weekly route plan?') THEN BEGIN
                        IF Rec.Status = Rec.Status::New THEN BEGIN
                            Rec.Status := Rec.Status::"Pending Approval";
                            Rec.MODIFY;
                            MESSAGE('Route Plan submitted successfully.');
                        END;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action("Send Weekly Feedback")
            {
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SendFeedback;

                trigger OnAction();
                begin
                    IF Rec.Status <> Rec.Status::Approved THEN
                        ERROR('Route plan must be approved.');

                    IF CONFIRM('Are you sure you want to submit your feedback for the week?') THEN BEGIN
                        IF Rec.Status = Rec.Status::Approved THEN BEGIN
                            MESSAGE('Feedback for the Route Plan submitted successfully.');
                        END;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action("Approve Route Plan")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = Approve;

                trigger OnAction();
                begin
                    User.GET(USERID);
                    IF Rec."Created By" = USERID THEN
                        ERROR('You cannot approve a route plan that you created.');

                    IF CONFIRM('Are you sure you want to approve the route plan?') THEN BEGIN
                        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
                            Rec.Status := Rec.Status::Approved;
                            Rec.MODIFY;
                            MESSAGE('Route Plan approved successfully.');
                        END;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            /*  action("Products Sold")
             {
                 Image = Bins;
                 Promoted = true;
                 PromotedCategory = Process;
                 PromotedIsBig = true;
                 PromotedOnly = true;
                 RunObject = Page 74326;
                 RunPageLink = No.=FIELD(No.);
                 Visible = SendFeedback;
             } */
        }
    }

    trigger OnOpenPage();
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            SubmitRoutePlan := TRUE;
            SendFeedback := FALSE;
            WriteFeedback := FALSE;
            EditDetails := TRUE;
            Approve := FALSE;
        END;

        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            SendFeedback := FALSE;
            SubmitRoutePlan := FALSE;
            WriteFeedback := FALSE;
            EditDetails := FALSE;
            Approve := TRUE;
        END;

        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            SendFeedback := TRUE;
            SubmitRoutePlan := FALSE;
            WriteFeedback := TRUE;
            EditDetails := TRUE;
            Approve := FALSE;
        END;

        User.GET(USERID);
    end;

    var
        SubmitRoutePlan: Boolean;
        SendFeedback: Boolean;
        WriteFeedback: Boolean;
        EditDetails: Boolean;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        User: Record "User Setup";
        Approve: Boolean;
}

