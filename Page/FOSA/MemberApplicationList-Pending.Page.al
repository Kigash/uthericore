page 50002 "Member Appl. List-Pending"
{
    // version TL2.0

    Caption = 'Pending Member Applications';
    CardPageID = "Member Application Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Related Information,Approval Request,Comments,Category 7,Category 8';
    RefreshOnActivate = true;
    SourceTable = "Member Application";
    SourceTableView = WHERE(Status = FILTER("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                /*  field(Surname; Surname)
                 {
                     ApplicationArea = All;
                 }
                 field("First Name"; Rec."First Name")
                 {
                     ApplicationArea = All;
                 }
                 field("Last Name"; Rec."Last Name")
                 {
                     ApplicationArea = All;
                 } */
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                /*   field("Registration Fee Paid"; Rec."Registration Fee Paid")
                  {
                      ApplicationArea = All;
                  }
                  field("Registration Fee Receipt No."; Rec."Registration Fee Receipt No.")
                  {
                      ApplicationArea = All;
                  } */
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';
                Visible = IsVisibleSendApprovalRequest;

                trigger OnAction()
                var
                ////ApprovalsMgmt: Codeunit "1535";
                begin
                    /*  IF ApprovalsMgmt.CheckMemberApplicationApprovalPossible(Rec) THEN
                         ApprovalsMgmt.OnSendMemberApplicationForApproval(Rec); */
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Visible = IsVisibleCancelApprovalRequest;

                trigger OnAction()
                var
                ////ApprovalsMgmt: Codeunit "1535";
                //WorkflowWebhookMgt: Codeunit "1543";
                begin
                    //ApprovalsMgmt.OnCancelMemberApplicationApprovalRequest(Rec);
                    //WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
                end;
            }
        }
        area(navigation)
        {
            action("Member Nominees")
            {
                Ellipsis = true;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;

                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::Nominee);
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50005, BeneficiaryType);
                end;
            }
            action("Next of Kin")
            {
                Ellipsis = true;
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;

                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Next of Kin");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50006, BeneficiaryType);
                end;
            }
            action(Agencies)
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;

                trigger OnAction()
                begin
                    Agency.FILTERGROUP(10);
                    Agency.SETRANGE("Member No.", Rec."No.");
                    Agency.FILTERGROUP(0);
                    PAGE.RUN(50052, Agency);
                end;
            }
            action("Monthly Contributions")
            {
                Ellipsis = true;
                Image = ElectronicPayment;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    MemberContribution.FILTERGROUP(10);
                    MemberContribution.SETRANGE("Application No.", Rec."No.");
                    MemberContribution.FILTERGROUP(0);
                    PAGE.RUN(50053, MemberContribution);
                end;
            }
            action("Group Members")
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;

                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Group Member");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50057, BeneficiaryType);
                end;
            }
            action("Group Trustees")
            {
                Image = Trace;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;

                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Group Trustee");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50059, BeneficiaryType);
                end;
            }
            action("Company Signatories")
            {
                Image = Company;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleCompany;

                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Company Signatory");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50056, BeneficiaryType);
                end;
            }
            action("Company Trustees")
            {
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleCompany;

                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Company Trustee");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50058, BeneficiaryType);
                end;
            }
            action("Joint Members")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleJoint;

                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Joint Member");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50071, BeneficiaryType);
                end;
            }
            action(Comments)
            {
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'View or add comments for the record.';

                trigger OnAction()
                var
                    ////ApprovalsMgmt: Codeunit "1535";
                    RecRef: RecordRef;
                begin
                    ApprovalCommentLine.FILTERGROUP(10);
                    ApprovalCommentLine.SETRANGE("Document No.", Rec."No.");
                    ApprovalCommentLine.FILTERGROUP(0);
                    ApprovalComments.SETTABLEVIEW(ApprovalCommentLine);
                    ApprovalComments.EDITABLE(FALSE);
                    ApprovalComments.RUN;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetVisible;
        SetEditable;
    end;

    trigger OnOpenPage()
    begin
        SetVisible;
        SetEditable;
    end;

    var
        BeneficiaryType: Record "Beneficiary Type";
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalComments: Page "Approval Comments";
        [InDataSet]


        IsVisibleIndividual: Boolean;
        [InDataSet]
        IsVisibleGroup: Boolean;
        [InDataSet]
        IsVisibleCompany: Boolean;
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        ////ApprovalsMgmt: Codeunit "1535";
        IsVisibleJoint: Boolean;
        IsVisibleSignature: Boolean;
        [InDataSet]
        IsVisiblePicture: Boolean;
        [InDataSet]
        IsVisibleFrontID: Boolean;
        [InDataSet]
        IsVisibleBackID: Boolean;
        IsVisibleCR: Boolean;
        CategoryOptions: Text[50];
        SelectedCategory: Integer;
        Agency: Record "Member Agency";
        MemberContribution: Record "Member Contribution";
        MemberApplication: Record "Member Application";

    local procedure SetVisible()
    begin
        IF Rec.Category = Rec.Category::Individual THEN BEGIN
            IsVisibleGroup := FALSE;
            IsVisibleCompany := FALSE;
            IsVisibleIndividual := TRUE;
            IsVisibleJoint := FALSE;
            IsVisiblePicture := TRUE;
            IsVisibleSignature := TRUE;
            IsVisibleBackID := TRUE;
            IsVisibleFrontID := TRUE;
            IsVisibleCR := FALSE;
        END ELSE
            IF Rec.Category = Rec.Category::Group THEN BEGIN
                IsVisibleIndividual := FALSE;
                IsVisibleCompany := FALSE;
                IsVisibleGroup := TRUE;
                IsVisibleJoint := FALSE;
                IsVisiblePicture := TRUE;
                IsVisibleSignature := FALSE;
                IsVisibleFrontID := FALSE;
                IsVisibleBackID := FALSE;
                IsVisibleCR := TRUE;
            END ELSE
                IF Rec.Category = Rec.Category::Company THEN BEGIN
                    IsVisibleIndividual := FALSE;
                    IsVisibleGroup := FALSE;
                    IsVisibleCompany := TRUE;
                    IsVisibleJoint := FALSE;
                    IsVisiblePicture := TRUE;
                    IsVisibleSignature := FALSE;
                    IsVisibleFrontID := FALSE;
                    IsVisibleBackID := FALSE;
                    IsVisibleCR := TRUE;
                END ELSE
                    IF Rec.Category = Rec.Category::Joint THEN BEGIN
                        IsVisibleGroup := FALSE;
                        IsVisibleCompany := FALSE;
                        IsVisibleIndividual := FALSE;
                        IsVisibleJoint := TRUE;
                        IsVisiblePicture := TRUE;
                        IsVisibleSignature := FALSE;
                        IsVisibleFrontID := FALSE;
                        IsVisibleBackID := FALSE;
                        IsVisibleCR := FALSE;
                    END;

        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleSendApprovalRequest := TRUE;
            IsVisibleCancelApprovalRequest := FALSE;
        END ELSE
            IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
                IsVisibleSendApprovalRequest := FALSE;
                IsVisibleCancelApprovalRequest := TRUE;
            END ELSE
                IF Rec.Status = Rec.Status::Approved THEN BEGIN
                    IsVisibleSendApprovalRequest := FALSE;
                    IsVisibleCancelApprovalRequest := FALSE;
                END ELSE
                    IF Rec.Status = Rec.Status::Rejected THEN BEGIN
                        IsVisibleSendApprovalRequest := FALSE;
                        IsVisibleCancelApprovalRequest := FALSE;
                    END;
    end;

    local procedure SetEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            IF Rec.Status = Rec.Status::"Pending Approval" THEN
                CurrPage.EDITABLE := FALSE
            ELSE
                IF Rec.Status = Rec.Status::Approved THEN
                    CurrPage.EDITABLE := FALSE
                ELSE
                    IF Rec.Status = Rec.Status::Rejected THEN
                        CurrPage.EDITABLE := FALSE
    end;
}
